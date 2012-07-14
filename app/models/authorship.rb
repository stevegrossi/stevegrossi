# == Schema Information
#
# Table name: authorships
#
#  id         :integer         not null, primary key
#  book_id    :integer
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Authorship < ActiveRecord::Base
  belongs_to :book
  belongs_to :author
end
