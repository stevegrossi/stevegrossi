require "spec_helper"

describe "Shows posts" do

  describe "posts archive" do
    it "displays published posts" do
      post1 = create(:post)
      post2 = create(:post)
      visit posts_path
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post2.title)
    end
    it "does not display drafts" do
      create(:draft_post, title: "This is a draft")
      visit posts_path
      expect(page).to_not have_content("This is a draft")
    end
  end

  describe "post page" do
    it "displays a post" do
      post = create(:post)
      visit post_path(post)
      within "h1" do
        expect(page).to have_content(post.title)
      end
    end
    it "displays drafts to authenticated users" do
      log_in_user
      post = create(:draft_post)
      visit post_path(post)
      within ".Flash--alert" do
        expect(page).to have_content("This is a draft")
      end
    end
    it "redirects unauthenticated requests to drafts to posts_path" do
      post = create(:draft_post)
      visit post_path(post)
      expect(current_path).to eq(posts_path)
      expect(page).to have_content("You must be logged in")
    end
  end
end

describe "post topics page" do
  before :each do
    @tag_kittens = Tag.create(name: "kittens")
    @tag_marshmallows = Tag.create(name: "marshmallows")
    @marshmallows = create(:post, tags: [@tag_marshmallows])
    @kittens_and_marshmallows = create(:post, tags: [@tag_kittens, @tag_marshmallows])
  end
  it "lists topics covered in posts" do
    visit tags_posts_path
    expect(page).to have_content("kittens (1)")
    expect(page).to have_content("marshmallows (2)")
  end
  it "lists posts about a topic" do
    visit tagged_posts_path("marshmallows")
    expect(page).to have_content(@marshmallows.title)
    expect(page).to have_content(@kittens_and_marshmallows.title)
  end
end

describe "Administrates posts" do
  before :each do
    log_in_user
  end
  describe "posts dashboard" do
    it "displays published and draft posts" do
      published = create(:post)
      draft = create(:draft_post)
      visit meta_posts_path
      expect(page).to have_content(published.title)
      expect(page).to have_content(draft.title)
    end
  end
  describe "new post page" do
    before :each do
      visit new_meta_post_path
    end
    context "with valid attributes" do
      before :each do
        fill_in "Title", with: "Test Title"
        fill_in "Content", with: "Test content."
        fill_in "Idea", with: "A test post"
      end
      it 'publishes a new post when you click "Publish"' do
        expect {
          click_button "Publish"
        }.to change(Post, :count).by(1)
        within "h1" do
          expect(page).to have_content "Test Title"
        end
        expect(page).to_not have_content("draft")
        expect(page).to have_selector(".Flash--notice")
      end
      it 'creates a new draft post when you click "Save Draft"' do
        expect {
          click_button "Save Draft"
        }.to change(Post, :count).by(1)
        within "h1" do
          expect(page).to have_content "Test Title"
        end
        within ".Flash--alert" do
          expect(page).to have_content("This is a draft")
        end
        expect(page).to have_selector(".Flash--notice")
      end
    end
    context "with invalid attributes" do
      it "shows errors without saving post" do
        expect {
          fill_in "Title", with: ""
          fill_in "Content", with: "Test content."
          fill_in "Idea", with: "A test post"
          click_button "Publish"
        }.not_to change(Post, :count)
        expect(page).to have_selector(".error")
      end
    end
  end
  describe "edit post page" do
    before :each do
      @post = create(:post)
      visit edit_meta_post_path(@post)
    end
    context "with valid attributes" do
      it "redirects to the updated post" do
        fill_in "Title", with: "Updated Title"
        click_button "Publish"
        within "h1" do
          expect(page).to have_content("Updated Title")
        end
        expect(page).to have_selector(".Flash--notice")
      end
      it 'unpublishes a post when you click "Unpublish"' do
        click_button "Unpublish"
        within ".Flash--alert" do
          expect(page).to have_content("draft")
        end
        expect(page).to have_selector(".Flash--notice")
      end
    end
    context "with invalid attributes" do
      it "re-renders the new post form with a flash" do
        fill_in "Title", with: ""
        click_button "Publish"
        within ".Flash" do
          expect(page).to have_content("errors")
        end
      end
    end
    context "when you click delete" do
      it "destroys the post and confirms" do
        expect {
          click_link "Delete this Post"
        }.to change(Post, :count).by(-1)
        within ".Flash--notice" do
          expect(page).to have_content("You deleted #{@post.title}")
        end
      end
    end
  end

end
