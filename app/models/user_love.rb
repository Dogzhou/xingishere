# == Schema Information
#
# Table name: user_loves
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  blog_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserLove < ActiveRecord::Base
  validates :user_id,   presence: true
  validates :blog_id,   presence: true
  belongs_to :user
  belongs_to :blog

  class << self
    def add(user_id, blog_id)
      tmp = UserLove.where("user_id = ? AND blog_id = ?", user_id, blog_id).first
      if tmp
        tmp.destroy
        0
      else
        UserLove.create(user_id: user_id, blog_id: blog_id)
        1
      end
    end
  end
end
