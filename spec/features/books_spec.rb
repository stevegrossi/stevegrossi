require "spec_helper"

describe "Shows books" do

  describe "books archive" do

    it "displays books by year" do
      book = create(:book)
      visit books_path
      expect(page).to have_content(book.end_date.year)
      expect(page).to have_selector("img[data-original=\"#{book.cover_url}\"]")
    end
  end

  describe "book page" do

    it "displays a book with multiple authors" do
      book = create(:book_with_two_authors)
      author1 = book.authors[0]
      author2 = book.authors[1]
      visit book_path(book)
      expect(page).to have_content(book.title)
      expect(page).to have_content(author1.full_name)
      expect(page).to have_content(author2.full_name)
    end
  end
end

describe "Administrates books" do

  before :each do
    log_in_user
  end

  describe "books dashboard" do

    it "displays all books" do
      book = create(:book)
      visit meta_books_path
      expect(page).to have_content(book.title)
    end

    context "when a book is unread" do
      it "provides a link to mark as read" do
        create(:unread_book)
        visit meta_books_path
        expect(page).to have_selector(:link_or_button, "Finish")
      end

      it "marks a book as read when clicked" do
        create(:unread_book)
        visit meta_books_path
        click_link "Finish"
        expect(page).to have_content(Time.now.to_date)
      end
    end
  end
  describe "new book page" do

    before :each do
      @author = create(:author)
      visit new_meta_book_path
    end

    context "with valid attributes" do
      before :each do
        fill_in "Title", with: "Test Title"
        fill_in "Publisher", with: "Test content."
        fill_in "Pub year", with: "A test book"
        select Time.now.year.to_s, from: "book_start_date_1i"
        select Date::MONTHNAMES[Time.now.month], from: "book_start_date_2i"
        select Time.now.day.to_s, from: "book_start_date_3i"
        select @author.full_name, from: "Author(s)"
      end

      it 'creates a new book when you click "Publish"' do
        expect {
          click_button "Publish"
        }.to change(Book, :count).by(1)
        expect(page).to have_content "Test Title"
        expect(page).to have_selector(".Flash--notice")
      end
    end

    context "with invalid attributes" do

      it "shows errors without saving book" do
        expect {
          click_button "Publish"
        }.not_to change(Book, :count)
        expect(page).to have_selector(".error")
      end
    end
  end
  describe "edit book page" do

    before :each do
      @book = create(:book)
      visit edit_meta_book_path(@book)
    end

    context "with valid attributes" do
      it "redirects to the updated book" do
        fill_in "Title", with: "Updated Title"
        click_button "Publish"
        expect(page).to have_content("Updated Title")
        expect(page).to have_selector(".Flash--notice")
      end
    end

    context "with invalid attributes" do
      it "re-renders the new book form with a flash" do
        fill_in "Title", with: ""
        click_button "Publish"
        within ".Flash" do
          expect(page).to have_content("errors")
        end
      end
    end

    context "when you click delete" do

      it "destroys the book and confirms" do
        expect {
          click_link "Delete this Book"
        }.to change(Book, :count).by(-1)
        within ".Flash--notice" do
          expect(page).to have_content("You deleted #{@book.title}")
        end
      end
    end
  end
end
