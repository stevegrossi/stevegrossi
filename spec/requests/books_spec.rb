require 'spec_helper'

describe 'Shows books' do
  describe 'books archive' do
    it 'displays published books' do
      book1 = FactoryGirl.create(:book)
      book2 = FactoryGirl.create(:book)
      visit books_path
      page.should have_content(book1.title)
      page.should have_content(book2.title)
    end
    it 'does not display drafts' do
      FactoryGirl.create(:draft_book, title: 'This is a draft')
      visit books_path
      page.should_not have_content('This is a draft')
    end
  end
  describe 'book page' do
    it 'displays a book with multiple authors' do
      book = FactoryGirl.create(:book_with_two_authors)
      author1 = book.authors[0]
      author2 = book.authors[1]
      visit book_path(book)
      within 'h1' do
        page.should have_content(book.title)
      end
      page.should have_content(author1.full_name)
      page.should have_content(author2.full_name)
    end
    it 'displays drafts to authenticated users' do
      log_in_user
      book = FactoryGirl.create(:draft_book)
      visit book_path(book)
      within '.alert' do
        page.should have_content('This is a draft')
      end
    end
    it 'redirects unauthenticated requests to drafts to books_path' do
      book = FactoryGirl.create(:draft_book)
      visit book_path(book)
      current_path.should == books_path
      page.should have_content('You must be logged in')
    end
    it 'shows the next and previous books' do
      first = FactoryGirl.create(:book)
      second = FactoryGirl.create(:book)
      third = FactoryGirl.create(:book)
      visit book_path(second)
      page.should have_content(first.title)
      page.should have_content(third.title)
    end
  end
end

describe 'Administrates books' do
  before :each do
    log_in_user
  end
  describe 'books dashboard' do
    it 'displays published and draft books' do
      published = FactoryGirl.create(:book)
      draft = FactoryGirl.create(:draft_book)
      visit meta_books_path
      page.should have_content(published.title)
      page.should have_content(draft.title)
    end
  end
  describe 'new book page' do
    before :each do
      @author = FactoryGirl.create(:author)
      visit new_meta_book_path
    end
    context 'with valid attributes' do
      before :each do
        fill_in 'Title', with: 'Test Title'
        fill_in 'Publisher', with: 'Test content.'
        fill_in 'Pub year', with: 'A test book'
        select @author.full_name, from: 'Author(s)'
        fill_in 'Thoughts', with: 'I think this was good.'
      end
      it 'creates a new book when you click "Publish"' do
        expect {
          click_button 'Publish'
        }.to change(Book, :count).by(1)
        within 'h1' do
          page.should have_content 'Test Title'
        end
        page.should have_selector('.notice')
      end
      it 'creates a new draft book when you click "Save Draft"' do
        expect {
          click_button 'Save Draft'
        }.to change(Book, :count).by(1)
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
      it 'shows errors without saving book' do
        expect {
          click_button 'Publish'
        }.not_to change(Book, :count)
        page.should have_selector('.error')
      end
    end
  end
  describe 'edit book page' do
    before :each do
      @book = FactoryGirl.create(:book)
      visit edit_meta_book_path(@book)
    end
    context 'with valid attributes' do
      it 'redirects to the updated book' do
        fill_in 'Title', with: 'Updated Title'
        click_button 'Publish'
        within 'h1' do
          page.should have_content('Updated Title')
        end
        page.should have_selector('.notice')
      end
      it 'unpublishes a book when you click "Unpublish"' do
        click_button 'Unpublish'
        within '.alert' do
          page.should have_content('draft')
        end
        page.should have_selector('.notice')
      end
    end
    context 'with invalid attributes' do
      it 're-renders the new book form with a flash' do
        fill_in 'Title', with: ''
        click_button 'Publish'
        within '.error' do
          page.should have_content('errors')
        end
      end
    end
    context 'when you click delete' do
      it 'destroys the book and confirms' do
        expect {
          click_link 'Delete this Book'
        }.to change(Book, :count).by(-1)
        within '.notice' do
          page.should have_content("You deleted #{@book.title}")
        end
      end
    end
  end
end
