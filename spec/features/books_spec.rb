require "spec_helper"

describe "Shows books" do

  describe "books archive" do
    let!(:book) { create(:book) }

    it "displays books by year" do
      visit books_path

      expect(page).to have_content(book.end_date.year)
      expect(page).to have_selector("img[data-original=\"#{book.cover_url}\"]")
    end
  end

  describe "book page" do
    let(:book) { create(:book, :with_two_authors) }
    let(:author1) { book.authors.first }
    let(:author2) { book.authors.second }

    it "displays a book with multiple authors" do
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

    context "with a book" do
      let!(:book) { create(:book) }

      it "displays all books" do
        visit meta_books_path

        expect(page).to have_content(book.title)
      end
    end

    context "when a book is unread" do
      let!(:unread_book) { create(:book, :unread) }

      before :each do
        visit meta_books_path
      end

      it "provides a link to mark as read" do
        expect(page).to have_selector(:link_or_button, "Finish")
      end

      it "marks a book as read when clicked" do
        click_link "Finish"

        expect(page).to have_content(Date.current)
      end
    end
  end

  describe "new book page" do
    let!(:author) { create(:author) }

    before :each do
      visit new_meta_book_path
    end

    context "with valid attributes" do

      before :each do
        fill_in "Title", with: "Test Title"
        fill_in "Publisher", with: "Test content."
        fill_in "Pub year", with: "A test book"
        select Time.current.year.to_s, from: "book_start_date_1i"
        select Date::MONTHNAMES[Time.current.month], from: "book_start_date_2i"
        select Time.current.day.to_s, from: "book_start_date_3i"
        select author.full_name, from: "Author(s)"
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
    let!(:book) { create(:book) }

    before :each do
      visit edit_meta_book_path(book)
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
          expect(page).to have_content("You deleted #{book.title}")
        end
      end
    end
  end
end
