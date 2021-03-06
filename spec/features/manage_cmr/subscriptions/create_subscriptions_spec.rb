describe 'Creating Subscriptions' do
  before do
    login
  end

  context 'when subscriptions is turned on' do
    before :all do
      @subscriptions_group = create_group(members: ['testuser', 'typical'])
      # the ACL is currently configured to work like Ingest, U covers CUD (of CRUD)
      @subscriptions_permissions = add_permissions_to_group(@subscriptions_group['concept_id'], ['update', 'read'], 'EMAIL_SUBSCRIPTION_MANAGEMENT', 'MMT_2')

      clear_cache
    end

    after :all do
      remove_group_permissions(@subscriptions_permissions['concept_id'])
      delete_group(concept_id: @subscriptions_group['concept_id'])

      clear_cache
    end

    context 'when visiting the new subscription form' do
      before do
        allow_any_instance_of(SubscriptionPolicy).to receive(:create?).and_return(true)
        allow_any_instance_of(SubscriptionPolicy).to receive(:show?).and_return(true)

        visit new_subscription_path
      end

      context 'when submitting the form without errors', js: true do
        let(:name) { "Exciting Subscription with Important Data #{SecureRandom.uuid}" }
        let(:query) { 'point=100,20&attribute\[\]=float,X\Y\Z,7&instrument\[\]=1B&cloud_cover=-70.0,120.0&equator_crossing_date=2000-01-01T10:00:00Z,2010-03-10T12:00:00Z&cycle[]=1&passes[0][pass]=1&passes[0][tiles]=1L,2F' }
        let(:collection_concept_id) { 'C1234-MMT_2' }

        before do
          fill_in 'Query', with: query
          fill_in 'Collection Concept ID', with: collection_concept_id

          VCR.use_cassette('urs/search/rarxd5taqea', record: :none) do
            within '.subscriber-group' do
              all('.select2-container .select2-selection').first.click
            end
            page.find('.select2-search__field').native.send_keys('rarxd5taqea')

            page.find('ul#select2-subscriber-results li.select2-results__option--highlighted').click
          end
        end

        context 'when submitting a subscription that succeeds' do
          before do
            fill_in 'Subscription Name', with: name
            # This is necessary to load the delete button for the subscription
            # clean up.
            # TODO: Remove when we can reset_provider
            allow_any_instance_of(SubscriptionPolicy).to receive(:destroy?).and_return(true)
            VCR.use_cassette('urs/rarxd5taqea', record: :none) do
              within '.subscription-form' do
                click_on 'Submit'
              end
            end
          end

          # TODO: using reset_provider may be cleaner than these after blocks,
          # but does not currently work. Reinvestigate after CMR-6310
          after do
            click_on 'Delete'
            click_on 'Yes'
          end

          it 'creates the subscription' do
            expect(page).to have_content('Subscription Created Successfully!')
          end
        end

        context 'when submitting a subscription that fails' do
          # Generating a genuine failure by violating uniqueness constraints
          # in the CMR.
          let(:name2) { 'Exciting Subscription with Important Data4' }
          before do
            @native_id_failure = 'test_native_id'
            @ingest_response, _search_response, _subscription = publish_new_subscription(name: name2, query: query, collection_concept_id: collection_concept_id, native_id: @native_id_failure)

            fill_in 'Subscription Name', with: name2
            VCR.use_cassette('urs/rarxd5taqea', record: :none) do
              within '.subscription-form' do
                click_on 'Submit'
              end
            end
          end

          # TODO: using reset_provider may be cleaner than these after blocks,
          # but does not currently work. Reinvestigate after CMR-6310
          after do
            delete_response = cmr_client.delete_subscription('MMT_2', @native_id_failure, 'token')
            raise unless delete_response.success?
          end

          it 'fails to create the subscription' do
            expect(page).to have_content('The Provider Id [MMT_2] and Subscription Name [Exciting Subscription with Important Data4] combination must be unique for a given native-id')
          end

          it 'repopulates the form with the entered values' do
            expect(page).to have_field('Subscription Name', with: name2)
            expect(page).to have_field('Query', with: query)

            within '.select2-container' do
              expect(page).to have_css('.select2-selection__rendered', text: 'Rvrhzxhtra Vetxvbpmxf')
            end
          end
        end
      end
    end
  end

  context 'when subscriptions is turned off' do
    before do
      allow(Mmt::Application.config).to receive(:subscriptions_enabled).and_return(false)
    end

    context 'when visiting the Manage Cmr page' do
      before do
        visit manage_cmr_path
      end

      it 'does not display the Subscriptions callout box' do
        expect(page).to have_no_css('h3.eui-callout-box__title', text: 'Subscriptions')
      end
    end

    context 'when visiting the new subscription form' do
      before do
        visit new_subscription_path
      end

      it 'displays the Manage Cmr page' do
        # Need to use the next line instead of the following line if js: true is on for these tests
        # expect(page).to have_css('h2.current', text: 'MANAGE CMR')
        expect(page).to have_css('h2.current', text: 'Manage CMR')

        expect(page).to have_css('h3.eui-callout-box__title', text: 'Permissions & Groups')
        expect(page).to have_css('h3.eui-callout-box__title', text: 'Orders')
      end

      it 'does not display the new subscription form' do
        expect(page).to have_no_field('Subscription Name')
        expect(page).to have_no_field('Query')
        expect(page).to have_no_field('Subscriber')
      end
    end
  end
end
