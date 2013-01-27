require 'spec_helper'

describe 'Shows posts' do

  describe "posts archive" do
    it 'displays published posts' do
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:post)
      visit posts_path
      page.should have_content(post1.title)
      page.should have_content(post2.title)
    end
    it 'does not display drafts' do
      FactoryGirl.create(:draft_post, title: 'This is a draft')
      visit posts_path
      page.should_not have_content('This is a draft')
    end
  end

  describe "post page" do
    it 'displays a post' do
      post = FactoryGirl.create(:post)
      visit post_path(post)
      within 'h1' do
        page.should have_content(post.title)
      end
    end
    it 'displays drafts to authenticated users' do
      log_in_user
      post = FactoryGirl.create(:draft_post)
      visit post_path(post)
      within '.alert' do
        page.should have_content('This is a draft')
      end
    end
    it 'redirects unauthenticated requests to drafts to posts_path' do
      post = FactoryGirl.create(:draft_post)
      visit post_path(post)
      current_path.should == posts_path
      page.should have_content('You must be logged in')
    end
  end
end

describe 'Administrates posts' do
  before :each do
    log_in_user
  end
  describe 'posts dashboard' do
    it 'displays published and draft posts' do
      published = FactoryGirl.create(:post)
      draft = FactoryGirl.create(:draft_post)
      visit meta_posts_path
      page.should have_content(published.title)
      page.should have_content(draft.title)
    end
  end
  describe 'new post page' do
    before :each do
      visit new_meta_post_path
    end
    context 'with valid attributes' do
      before :each do
        fill_in 'Title', with: 'Test Title'
        fill_in 'Content', with: 'Test content.'
        fill_in 'Idea', with: 'A test post'
      end
      it 'publishes a new post when you click "Publish"' do
        expect {
          click_button 'Publish'
        }.to change(Post, :count).by(1)
        within 'h1' do
          page.should have_content 'Test Title'
        end
        page.should_not have_content('draft')
        page.should have_selector('.notice')
      end
      it 'creates a new draft post when you click "Save Draft"' do
        expect {
          click_button 'Save Draft'
        }.to change(Post, :count).by(1)
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
      it 'shows errors without saving post' do
        expect {
          fill_in 'Title', with: ''
          fill_in 'Content', with: 'Test content.'
          fill_in 'Idea', with: 'A test post'
          click_button 'Publish'
        }.not_to change(Post, :count)
        page.should have_selector('.error')
      end
    end
  end
  describe 'edit post page' do
    before :each do
      @post = FactoryGirl.create(:post)
      visit edit_meta_post_path(@post)
    end
    context 'with valid attributes' do
      it 'redirects to the updated post' do
        fill_in 'Title', with: 'Updated Title'
        click_button 'Publish'
        within 'h1' do
          page.should have_content('Updated Title')
        end
        page.should have_selector('.notice')
      end
      it 'unpublishes a post when you click "Unpublish"' do
        click_button 'Unpublish'
        within '.alert' do
          page.should have_content('draft')
        end
        page.should have_selector('.notice')
      end
    end
    context 'with invalid attributes' do
      it 're-renders the new post form with a flash' do
        fill_in 'Title', with: ''
        click_button 'Publish'
        within '.error' do
          page.should have_content('errors')
        end
      end
    end
    context 'when you click delete' do
      it 'destroys the post and confirms' do
        expect {
          click_link 'Delete this Post'
        }.to change(Post, :count).by(-1)
        within '.notice' do
          page.should have_content("You deleted #{@post.title}")
        end
      end
    end
  end

end
