describe 'Proposals listed on the Manage Collection Proposals page' do
  draft_proposal_display_max_count = 5 # should agree with @draft_proposal_display_max_count found in manage_collection_proposals_controller

  before do
    set_as_proposal_mode_mmt
    login
  end

  context 'when no proposals exist' do
    before do
      visit manage_collection_proposals_path
    end

    it 'no drafts are displayed' do
      expect(page).to have_content('Collection Draft Proposals')

      expect(page).to have_content('There are no draft proposals to display.')
    end
  end

  context 'when there are proposals' do
    before do
      4.times { create(:full_collection_draft_proposal) }
      create(:full_collection_draft_proposal, draft_short_name: 'An Example Proposal', version: '5', draft_entry_title: 'An Example Proposal Title')
      create(:full_collection_draft_proposal, draft_short_name: 'An Example Proposal2', version: '')

      visit manage_collection_proposals_path
    end

    it 'has a more button' do
      expect(page).to have_link('More')
    end

    it 'displays versions correctly' do
      expect(page).to have_content('An Example Proposal_5')
      expect(page).to have_content('An Example Proposal2')
    end

    it 'displays entry titles' do
      expect(page).to have_content('An Example Proposal Title')
    end

    context 'when visiting the index page' do
      before do
        visit collection_draft_proposals_path
      end

      it 'displays versions correctly' do
        expect(page).to have_content('An Example Proposal_5')
        expect(page).to have_content('An Example Proposal2')
      end

      it 'displays entry titles' do
        expect(page).to have_content('An Example Proposal Title')
      end
    end
  end
end