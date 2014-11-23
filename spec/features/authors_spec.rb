require 'spec_helper'

describe 'Shows authors' do

  describe "authors archive" do
    it 'displays published authors' do
      author1 = create(:author)
      author2 = create(:author)
      visit authors_path
      expect(page).to have_content(author1.full_name)
      expect(page).to have_content(author2.full_name)
    end
  end

  describe 'author page' do
    context 'when an author has books' do
      it 'displays an author and their books' do
        book = create(:book)
        author = book.authors.first
        visit author_path(author)
        within 'h1' do
          expect(page).to have_content(author.full_name)
        end
        expect(page).to have_content(book.title)
      end
    end
    context 'when an author has no books' do
      it 'shows a message' do
        author = create(:author)
        visit author_path(author)
        expect(page).to have_content('I actually haven’t read')
      end
    end
  end
end

describe 'Administrates authors' do
  before :each do
    log_in_user
  end
  describe 'authors dashboard' do
    it 'displays all authors and their book' do
      book = create(:book)
      author = book.authors.first
      visit meta_authors_path
      expect(page).to have_content(author.fname)
      expect(page).to have_content(book.title)
    end
  end
  describe 'new author page' do
    before :each do
      visit new_meta_author_path
    end
    context 'with valid attributes' do
      it 'creates a new author' do
        expect {
          fill_in 'First', with: 'Steve'
          fill_in 'Middle', with: 'M.'
          fill_in 'Last', with: 'Grossi'
          click_button 'Create Author'
        }.to change(Author, :count).by(1)
        within 'h1' do
          expect(page).to have_content 'Steve M. Grossi'
        end
        expect(page).to have_selector('.notice')
      end
    end
    context 'with invalid attributes' do
      it 'shows errors without saving author' do
        expect {
          click_button 'Create Author'
        }.not_to change(Author, :count)
        expect(page).to have_selector('.error')
      end
    end
  end
  describe 'edit author page' do
    before :each do
      @author = create(:author)
      visit edit_meta_author_path(@author)
    end
    context 'with valid attributes' do
      it 'redirects to the updated author' do
        fill_in 'First', with: 'Newname'
        click_button 'Update Author'
        within 'h1' do
          expect(page).to have_content('Newname')
        end
        expect(page).to have_selector('.notice')
      end
    end
    context 'with invalid attributes' do
      it 're-renders the new author form with a flash' do
        fill_in 'First', with: ''
        click_button 'Update Author'
        within '.flash' do
          expect(page).to have_content('errors')
        end
      end
    end
    context 'when you click delete' do
      it 'destroys the author and confirms' do
        expect {
          click_link 'Delete this Author'
        }.to change(Author, :count).by(-1)
        within '.notice' do
          expect(page).to have_content("You deleted #{@author.full_name}")
        end
      end
    end
  end
end
