# coding: utf-8
require 'spec_helper'

describe 'Search' do
  before :each do
    visit search_path
  end
  it 'returns search results with titles and excerpts' do
    create(:post,
      title: 'Old MacDonald Had a Farm',
      content: 'Ee Ii Ee Ii Oo. And on this farm he had a pig.')
    fill_in 'for', with: 'pig'
    click_button 'Search'
    page.should have_content('MacDonald')
    page.should have_content('had a pig')
  end
  it 'doesn’t return draft posts' do
    create(:draft_post,
      title: 'Old MacDonald Had a Farm',
      content: 'Ee Ii Ee Ii Oo. And on this farm he had a pig.')
    fill_in 'for', with: 'pig'
    click_button 'Search'
    page.should_not have_content('had a pig')
  end
  it 'tells you if there are no results' do
    fill_in 'for', with: 'pig'
    click_button 'Search'
    page.should have_content('no results')
  end
  it 'thumbs its nose at filthy search terms' do
    fill_in 'for', with: 'fuck'
    click_button 'Search'
    page.should have_content('You kiss your mother with that mouth?')
  end
end
