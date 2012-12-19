# coding: utf-8
require 'spec_helper'

describe Book do
  it 'has a valid factory' do
    FactoryGirl.build(:work).should be_valid
  end
  it 'is invalid without a title' do
    FactoryGirl.build(:work, title: nil).should_not be_valid
  end
  it 'is invalid without a summary' do
    FactoryGirl.build(:work, about: nil).should_not be_valid
  end
  it 'is invalid without an image filename' do
    FactoryGirl.build(:work, image_filename: nil).should_not be_valid
  end
  it 'provides a description' do
    work_with_all = FactoryGirl.build(:work,
      url: 'http://stevegrossi.com',
      client: 'Steve Grossi',
      published_at: Date.parse('2011-05-06'))
    work_without_url = FactoryGirl.build(:work,
      title: 'Steve’s homepage',
      client: 'Steve Grossi',
      published_at: Date.parse('2011-05-06'))
    work_without_client = FactoryGirl.build(:work,
      url: 'http://stevegrossi.com',
      published_at: Date.parse('2011-05-06'))
    draft_work = FactoryGirl.build(:work,
      url: 'http://stevegrossi.com',
      client: 'Steve Grossi',
      published_at: nil)
    work_with_all.description.should eq('I built stevegrossi.com for Steve Grossi in May 2011.')
    work_without_url.description.should eq('I built Steve’s homepage for Steve Grossi in May 2011.')
    work_without_client.description.should eq('I built stevegrossi.com in May 2011.')
    draft_work.description.should eq('I built stevegrossi.com for Steve Grossi.')
  end
  it_behaves_like 'a Postable', :work
end
