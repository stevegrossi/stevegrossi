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
    expect(build(:redirect)).to be_valid
  end
  it 'is invalid without somewhere to redirect from' do
    redirect = build(:redirect, from: nil)
    expect(redirect).to_not be_valid
    expect(redirect.errors[:from].size).to eq(1)
  end
  it 'is invalid without somewhere to redirect to' do
    redirect = build(:redirect, to: nil)
    expect(redirect).to_not be_valid
  end
  it 'is invalid without a URL to redirect to' do
    redirect = build(:redirect, to: 'EVERYWHERE!')
    expect(redirect).to_not be_valid
  end
  it 'only allows one redirect from a single place' do
    create(:redirect, from: 'somewhere')
    expect(build(:redirect, from: 'somewhere')).to_not be_valid
  end
end
