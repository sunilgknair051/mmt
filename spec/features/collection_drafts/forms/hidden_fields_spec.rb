# MMT-1571

describe 'Removed field', js: true do
  before do
    login
    draft = create(:full_collection_draft, user: User.where(urs_uid: 'testuser').first)
    visit collection_draft_path(draft)
  end


  context 'when field was avaiable' do

    it 'collection draft should still contain DirectoryNames' do
      draft = CollectionDraft.first
      expect(draft.draft.keys).to include('DirectoryNames')
    end
  end
end
