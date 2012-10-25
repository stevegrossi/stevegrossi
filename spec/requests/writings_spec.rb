require 'spec_helper'

describe 'Manages writings' do
  describe "GET /wrote" do
    it 'displays published writings' do
      FactoryGirl.create(:writing, title: 'I wrote this')
      visit writings_path
      page.should have_content('I wrote this')
    end
    context 'as authenticated user' do
      before :each do
        log_in_user
      end
      it 'displays drafts' do
        writing = FactoryGirl.create(:writing, title: 'This is a draft', published_at: nil)
        visit writing_path(writing)
        page.should have_content('This is a draft')
      end
    end
    context 'as unauthenticated user' do
      it 'does not display drafts' do
        FactoryGirl.create(:writing, title: 'This is a draft', published_at: nil)
        visit writings_path
        page.should_not have_content('This is a draft')
      end
    end
  end
  describe "GET /wrote/writing" do
    it 'displays a writing' do
      writing = FactoryGirl.create(:writing, title: 'Lorem ipsum')
      visit writing_path(writing)
      page.should have_content('Lorem ipsum')
    end
    it 'redirects requests to drafts to writings_path' do
      writing = FactoryGirl.create(:writing, title: 'This is a draft', published_at: nil)
      visit writing_path(writing)
      current_path.should == writings_path
      page.should have_content('You must be logged in')
    end
  end
end
