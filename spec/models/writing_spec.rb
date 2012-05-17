require 'spec_helper'

describe Writing do
  pending "add some examples to (or delete) #{__FILE__}"
end


# == Schema Information
#
# Table name: writings
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  content        :text
#  summary        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  publish_status :string(255)     default("published")
#

