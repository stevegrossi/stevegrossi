# == Schema Information
#
# Table name: authorships
#
#  id         :integer(4)      not null, primary key
#  book_id    :integer(4)
#  author_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Authorship < ActiveRecord::Base
  belongs_to :book
  belongs_to :author
end
