require 'spec_helper'

describe 'Shows books' do
  describe 'books archive' do
    it 'displays currently reading books' do
      unread = create(:unread_book)
      visit books_path
      page.should have_content(unread.title)
    end
    it 'does not display read books I am not writing about' do
      read = create(:book)
      visit books_path
      page.should_not have_content(read.title)
    end
    it 'displays books I am writing about' do
      read = create(:book)
      create(:draft_post, book: read)
      visit books_path
      page.should have_content(read.title)
    end
  end
  describe 'book page' do
    it 'displays a book with multiple authors' do
      book = create(:book_with_two_authors)
      author1 = book.authors[0]
      author2 = book.authors[1]
      visit book_path(book)
      page.should have_content(book.title)
      page.should have_content(author1.full_name)
      page.should have_content(author2.full_name)
    end
  end
end

describe 'Administrates books' do
  before :each do
    log_in_user
  end
  describe 'books dashboard' do
    it 'displays all books' do
      book = create(:book)
      visit meta_books_path
      page.should have_content(book.title)
    end
    context 'when a book is unread' do
      it 'provides a link to mark as read' do
        create(:unread_book)
        visit meta_books_path
        page.should have_selector(:link_or_button, 'Finish')
      end
      it 'marks a book as read when clicked' do
        create(:unread_book)
        visit meta_books_path
        click_link 'Finish'
        page.should have_content(Time.now.to_date)
      end
    end
  end
  describe 'new book page' do
    before :each do
      @author = create(:author)
      visit new_meta_book_path
    end
    context 'with valid attributes' do
      before :each do
        fill_in 'Title', with: 'Test Title'
        fill_in 'Publisher', with: 'Test content.'
        fill_in 'Pub year', with: 'A test book'
        select Time.now.year.to_s, from: "book_start_date_1i"
        select Date::MONTHNAMES[Time.now.month], from: "book_start_date_2i"
        select Time.now.day.to_s, from: "book_start_date_3i"
        select @author.full_name, from: 'Author(s)'
      end
      it 'creates a new book when you click "Publish"' do
        expect {
          click_button 'Publish'
        }.to change(Book, :count).by(1)
        page.should have_content 'Test Title'
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
      @book = create(:book)
      visit edit_meta_book_path(@book)
    end
    context 'with valid attributes' do
      it 'redirects to the updated book' do
        fill_in 'Title', with: 'Updated Title'
        click_button 'Publish'
        page.should have_content('Updated Title')
        page.should have_selector('.notice')
      end
    end
    context 'with invalid attributes' do
      it 're-renders the new book form with a flash' do
        fill_in 'Title', with: ''
        click_button 'Publish'
        within '.flash' do
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
