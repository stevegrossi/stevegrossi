require 'spec_helper'

describe 'Shows writings' do

  describe "writings archive" do
    it 'displays published writings' do
      writing1 = FactoryGirl.create(:writing)
      writing2 = FactoryGirl.create(:writing)
      visit writings_path
      page.should have_content(writing1.title)
      page.should have_content(writing2.title)
    end
    it 'does not display drafts' do
      FactoryGirl.create(:draft_writing, title: 'This is a draft')
      visit writings_path
      page.should_not have_content('This is a draft')
    end
  end

  describe "writing page" do
    it 'displays a writing' do
      writing = FactoryGirl.create(:writing)
      visit writing_path(writing)
      within 'h1' do
        page.should have_content(writing.title)
      end
    end
    it 'displays drafts to authenticated users' do
      log_in_user
      writing = FactoryGirl.create(:draft_writing)
      visit writing_path(writing)
      within '.alert' do
        page.should have_content('This is a draft')
      end
    end
    it 'redirects unauthenticated requests to drafts to writings_path' do
      writing = FactoryGirl.create(:draft_writing)
      visit writing_path(writing)
      current_path.should == writings_path
      page.should have_content('You must be logged in')
    end
  end
end

describe 'Administrates writings' do
  before :each do
    log_in_user
  end
  describe 'writings dashboard' do
    it 'displays published and draft writings' do
      published = FactoryGirl.create(:writing)
      draft = FactoryGirl.create(:draft_writing)
      visit meta_writings_path
      page.should have_content(published.title)
      page.should have_content(draft.title)
    end
  end
  describe 'new writing page' do
    before :each do
      visit new_meta_writing_path
    end
    context 'with valid attributes' do
      before :each do
        fill_in 'Title', with: 'Test Title'
        fill_in 'Content', with: 'Test content.'
        fill_in 'Summary', with: 'A test writing'
      end
      it 'creates a new writing when you click "Publish"' do
        expect {
          click_button 'Publish'
        }.to change(Writing, :count).by(1)
        within 'h1' do
          page.should have_content 'Test Title'
        end
        page.should have_selector('.notice')
      end
      it 'creates a new draft writing when you click "Save Draft"' do
        expect {
          click_button 'Save Draft'
        }.to change(Writing, :count).by(1)
        within 'h1' do
          page.should have_content 'Test Title'
        end
        within '.alert' do
          page.should have_content('This is a draft')
        end
        page.should have_selector('.notice')
      end
    end
    context 'with invalid attributes' do
      it 'shows errors without saving writing' do
        expect {
          fill_in 'Title', with: ''
          fill_in 'Content', with: 'Test content.'
          fill_in 'Summary', with: 'A test writing'
          click_button 'Publish'
        }.not_to change(Writing, :count)
        page.should have_selector('.error')
      end
    end
  end
  describe 'edit writing page' do
    before :each do
      @writing = FactoryGirl.create(:writing)
      visit edit_meta_writing_path(@writing)
    end
    context 'with valid attributes' do
      it 'redirects to the updated writing' do
        fill_in 'Title', with: 'Updated Title'
        click_button 'Publish'
        within 'h1' do
          page.should have_content('Updated Title')
        end
        page.should have_selector('.notice')
      end
      it 'unpublishes a writing when you click "Unpublish"' do
        click_button 'Unpublish'
        within '.alert' do
          page.should have_content('draft')
        end
        page.should have_selector('.notice')
      end
    end
    context 'with invalid attributes' do
      it 're-renders the new writing form with a flash' do
        fill_in 'Title', with: ''
        click_button 'Publish'
        within '.error' do
          page.should have_content('errors')
        end
      end
    end
    context 'when you click delete' do
      it 'destroys the writing and confirms' do
        expect {
          click_link 'Delete this Writing'
        }.to change(Writing, :count).by(-1)
        within '.notice' do
          page.should have_content("You deleted #{@writing.title}")
        end
      end
    end
  end

end
