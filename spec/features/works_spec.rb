require 'spec_helper'

describe 'Shows works' do

  describe "works archive" do
    it 'displays published works' do
      work1 = create(:work)
      work2 = create(:work)
      visit works_path
      page.should have_content(work1.title)
      page.should have_content(work2.title)
    end
    it 'does not display drafts' do
      create(:draft_work, title: 'This is a draft')
      visit works_path
      page.should_not have_content('This is a draft')
    end
  end

  describe "work page" do
    it 'displays a work' do
      work = create(:work)
      visit work_path(work)
      within 'h1' do
        page.should have_content(work.title)
      end
    end
    it 'displays drafts to authenticated users' do
      log_in_user
      work = create(:draft_work)
      visit work_path(work)
      within '.alert' do
        page.should have_content('This is a draft')
      end
    end
    it 'redirects unauthenticated requests to drafts to works_path' do
      work = create(:draft_work)
      visit work_path(work)
      current_path.should == works_path
      page.should have_content('You must be logged in')
    end
  end
end

describe 'Administrates works' do
  before :each do
    log_in_user
  end
  describe 'works dashboard' do
    it 'displays published and draft works' do
      published = create(:work)
      draft = create(:draft_work)
      visit meta_works_path
      page.should have_content(published.title)
      page.should have_content(draft.title)
    end
  end
  describe 'new work page' do
    before :each do
      visit new_meta_work_path
    end
    context 'with valid attributes' do
      before :each do
        fill_in 'Title', with: 'Test Title'
        fill_in 'About', with: 'Test content.'
        fill_in 'Image filename', with: 'http://placekitten.com/600/400'
      end
      it 'creates a new work when you click "Publish"' do
        expect {
          click_button 'Publish'
        }.to change(Work, :count).by(1)
        within 'h1' do
          page.should have_content('Test Title')
        end
        page.should have_selector('.notice')
      end
      it 'creates a new draft work when you click "Save Draft"' do
        expect {
          click_button 'Save Draft'
        }.to change(Work, :count).by(1)
        within 'h1' do
          page.should have_content 'Test Title'
        end
        page.should have_selector('.notice')
        within '.alert' do
          page.should have_content('This is a draft')
        end
      end
    end
    context 'with invalid attributes' do
      it 'shows errors without saving work' do
        expect {
          fill_in 'Title', with: ''
          fill_in 'About', with: 'Test content.'
          click_button 'Publish'
        }.not_to change(Work, :count)
        page.should have_selector('.error')
      end
    end
  end
  describe 'edit work page' do
    before :each do
      @work = create(:work)
      visit edit_meta_work_path(@work)
    end
    context 'with valid attributes' do
      it 'redirects to the updated work' do
        fill_in 'Title', with: 'Updated Title'
        click_button 'Publish'
        page.should have_selector('.notice')
        within 'h1' do
          page.should have_content('Updated Title')
        end
      end
      it 'unpublishes a work when you click "Unpublish"' do
        click_button 'Unpublish'
        within '.alert' do
          page.should have_content('draft')
        end
        page.should have_selector('.notice')
      end
    end
    context 'with invalid attributes' do
      it 're-renders the new work form with a flash' do
        fill_in 'Title', with: ''
        click_button 'Publish'
        within '.flash' do
          page.should have_content('errors')
        end
      end
    end
    context 'when you click delete' do
      it 'destroys the work and confirms' do
        expect {
          click_link 'Delete this Work'
        }.to change(Work, :count).by(-1)
        within '.notice' do
          page.should have_content("You deleted #{@work.title}")
        end
      end
    end
  end

end
