# == Schema Information
#
# Table name: redirects
#
#  id         :integer          not null, primary key
#  from       :string(255)
#  to         :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Redirect do
  it 'has a valid factory' do
    build(:redirect).should be_valid
  end
  it 'is invalid without somewhere to redirect from' do
    redirect = build(:redirect, from: nil)
    redirect.should_not be_valid
    redirect.should have(1).error_on(:from)
  end
  it 'is invalid without somewhere to redirect to' do
    redirect = build(:redirect, to: nil)
    redirect.should_not be_valid
  end
  it 'is invalid without a URL to redirect to' do
    redirect = build(:redirect, to: 'EVERYWHERE!')
    redirect.should_not be_valid
  end
  it 'only allows one redirect from a single place' do
    create(:redirect, from: 'somewhere')
    build(:redirect, from: 'somewhere').should_not be_valid
  end
end
