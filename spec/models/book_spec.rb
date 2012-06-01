# == Schema Information
#
# Table name: books
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  author         :string(255)
#  publisher      :string(255)
#  pub_year       :string(255)
#  asin           :string(255)
#  thoughts       :text
#  created_at     :datetime
#  updated_at     :datetime
#  subtitle       :string(255)
#  cover_image    :string(255)
#  publish_status :string(255)     default("published")
#  thesis         :text
#

require 'spec_helper'

describe Book do
  pending "add some examples to (or delete) #{__FILE__}"
end



