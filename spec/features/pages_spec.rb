require 'spec_helper'

describe 'Publicly' do

  it 'displays a page' do
    the_page = create(:page)
    visit page_path(the_page)
    expect(page).to have_content(the_page.title)
    expect(page).to have_content(the_page.content)
  end

  it 'sets the permalink as the url' do
    the_page = create(:page)
    visit page_path(the_page)
    expect(current_path).to eq("/#{the_page.permalink}")
  end

  it 'allows slashes in permalinks' do
    the_page = create(:page, permalink: 'is/awesome')
    visit 'is/awesome'
    expect(current_path).to eq('/is/awesome')
  end
end

describe 'Administrates pages' do

  before :each do
    log_in_user
  end

  describe 'pages dashboard' do

    it 'displays pages' do
      the_page = create(:page)
      visit meta_pages_path
      expect(page).to have_content(the_page.title)
    end
  end

  describe 'when creating a page' do

    before :each do
      visit new_meta_page_path
    end

    context 'with valid attributes' do

      before :each do
        fill_in 'Title', with: 'Test Title'
        fill_in 'Permalink', with: 'test'
        fill_in 'Content', with: 'A test page'
      end

      it 'creates a new page when you click "Publish"' do
        expect {
          click_button 'Publish'
        }.to change(Page, :count).by(1)
        within 'h1' do
          expect(page).to have_content 'Test Title'
        end
      end
    end

    context 'with invalid attributes' do

      it 'shows errors without saving page' do
        expect {
          fill_in 'Title', with: ''
          fill_in 'Permalink', with: 'test'
          fill_in 'Content', with: 'A test page'
          click_button 'Publish'
        }.not_to change(Page, :count)
        expect(page).to have_selector('.error')
      end
    end
  end

  describe 'editing pages' do

    before :each do
      @page = create(:page, permalink: 'is/awesome')
      visit edit_meta_page_path(@page)
    end

    context 'with valid attributes' do

      it 'redirects to the updated page' do
        fill_in 'Title', with: 'Updated Title'
        click_button 'Publish'
        within 'h1' do
          expect(page).to have_content('Updated Title')
        end
      end
    end

    context 'with invalid attributes' do

      it 're-renders the new page form with a flash' do
        fill_in 'Title', with: ''
        click_button 'Publish'
        within '.Flash' do
          expect(page).to have_content('errors')
        end
      end
    end

    context 'when you click delete' do

      it 'destroys the page and confirms' do
        expect {
          click_link 'Delete this Page'
        }.to change(Page, :count).by(-1)
        within '.Flash--notice' do
          expect(page).to have_content("You deleted the page #{@page.title}")
        end
      end
    end
  end

end
