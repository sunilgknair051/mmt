describe 'Invalid Variable Draft Variable Information Preview' do
  before do
    login
    @draft = create(:invalid_variable_draft, user: User.where(urs_uid: 'testuser').first)
    visit variable_draft_path(@draft)
  end

  context 'When examining the Variable Information section' do
    it 'displays the form title as an edit link' do
      within '#variable_information-progress' do
        expect(page).to have_link('Variable Information', href: edit_variable_draft_path(@draft, 'variable_information'))
      end
    end

    it 'displays the correct status icon' do
      within '#variable_information-progress' do
        within '.status' do
          expect(page).to have_content('Variable Information is incomplete')
        end
      end
    end

    it 'displays the correct progress indicators for required fields' do
      within '#variable_information-progress .progress-indicators' do
        expect(page).to have_css('.eui-icon.eui-required-o.icon-green.name')
        expect(page).to have_css('.eui-icon.eui-required-o.icon-green.definition')
        expect(page).to have_css('.eui-icon.eui-required-o.icon-green.long-name')
        expect(page).to have_css('.eui-icon.eui-required-o.icon-green.data-type')
      end
    end

    it 'displays the correct progress indicators for non required fields' do
      within '#variable_information-progress .progress-indicators' do
        expect(page).to have_css('.eui-icon.eui-fa-circle-o.icon-grey.alias')
        expect(page).to have_css('.eui-icon.eui-fa-circle-o.icon-grey.variable-type')
        expect(page).to have_css('.eui-icon.eui-fa-circle-o.icon-grey.units')
        expect(page).to have_css('.eui-icon.eui-fa-circle-o.icon-grey.variable-type')
        expect(page).to have_css('.eui-icon.eui-fa-circle-o.icon-grey.variable-sub-type')
      end
    end

    it 'displays the correct progress indicators for invalid fields' do
      within '#variable_information-progress .progress-indicators' do
        expect(page).to have_css('.eui-icon.eui-fa-minus-circle.icon-red.scale')
        expect(page).to have_css('.eui-icon.eui-fa-minus-circle.icon-red.offset')
        expect(page).to have_css('.eui-icon.eui-fa-minus-circle.icon-red.valid-ranges')
      end
    end

    it 'displays the stored values correctly within the preview' do
      within '.umm-preview.variable_information' do
        expect(page).to have_css('.umm-preview-field-container', count: 16)

        within '#variable_draft_draft_name_preview' do
          expect(page).to have_css('h5', text: 'Name')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_name'))

          expect(page).to have_css('p', text: 'No value for Name provided.')
        end

        within '#variable_draft_draft_alias_preview' do
          expect(page).to have_css('h5', text: 'Alias')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_alias'))

          expect(page).to have_css('p', text: 'No value for Alias provided.')
        end

        within '#variable_draft_draft_long_name_preview' do
          expect(page).to have_css('h5', text: 'Long Name')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_long_name'))

          expect(page).to have_css('p', text: 'No value for Long Name provided.')
        end

        within '#variable_draft_draft_definition_preview' do
          expect(page).to have_css('h5', text: 'Definition')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_definition'))

          expect(page).to have_css('p', text: 'No value for Definition provided.')
        end

        within '#variable_draft_draft_variable_type_preview' do
          expect(page).to have_css('h5', text: 'Variable Type')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_variable_type'))

          expect(page).to have_css('p', text: 'No value for Variable Type provided.')
        end

        within '#variable_draft_draft_variable_sub_type_preview' do
          expect(page).to have_css('h5', text: 'Variable Sub Type')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_variable_sub_type'))

          expect(page).to have_css('p', text: 'No value for Variable Sub Type provided.')
        end

        within '#variable_draft_draft_units_preview' do
          expect(page).to have_css('h5', text: 'Units')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_units'))

          expect(page).to have_css('p', text: 'No value for Units provided.')
        end

        within '#variable_draft_draft_data_type_preview' do
          expect(page).to have_css('h5', text: 'Data Type')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_data_type'))

          expect(page).to have_css('p', text: 'No value for Data Type provided.')
        end

        within '#variable_draft_draft_scale_preview' do
          expect(page).to have_css('h5', text: 'Scale')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_scale'))

          expect(page).to have_css('p', text: 'string')
        end

        within '#variable_draft_draft_offset_preview' do
          expect(page).to have_css('h5', text: 'Offset')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_offset'))

          expect(page).to have_css('p', text: 'string')
        end

        within '#variable_draft_draft_acquisition_source_name_preview' do
          expect(page).to have_css('h5', text: 'Acquisition Source Name')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_acquisition_source_name'))
          expect(page).to have_css('p', text: 'No value for Acquisition Source Name provided.')
        end

        within '#variable_draft_draft_valid_ranges_preview' do
          expect(page).to have_css('h5', text: 'Valid Ranges')
          expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_valid_ranges'))

          expect(page).to have_css('h6', text: 'Valid Range 1')

          within '#variable_draft_draft_valid_ranges_0_min_preview' do
            expect(page).to have_css('h5', text: 'Min')
            expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_valid_ranges_0_min'))
            expect(page).to have_css('p', text: 'string')
          end

          within '#variable_draft_draft_valid_ranges_0_max_preview' do
            expect(page).to have_css('h5', text: 'Max')
            expect(page).to have_link(nil, href: edit_variable_draft_path(@draft, 'variable_information', anchor: 'variable_draft_draft_valid_ranges_0_max'))
            expect(page).to have_css('p', text: 'string')
          end

        end
      end
    end
  end
end
