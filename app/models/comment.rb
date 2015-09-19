# == Schema Information
#
# Table name: comments
#
#  id             :integer          not null, primary key
#  content        :string(160)
#  blog_id        :integer
#  user_id        :integer
#  pid            :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publish_status :boolean          default(TRUE), not null
#  remote_ip      :string(20)       default(""), not null   # ;IP
#  nickname       :string(20)       default(""), not null
#  email          :string(50)       default(""), not null
#

# encoding : utf-8
class Comment < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :blog

  validates :user_id, :blog_id, :nickname, :email, :content,      presence: true
  validates :nickname, length: { minimum: 1, maximum: 8 }
  validates :content,  length: { minimum: 1, maximum: 160 }
  validate_harmonious_of :nickname, message: '昵称里也敢放敏感词...想喝茶了吗'
  validate_harmonious_of :content,  message: '内容里不要放敏感词嘛...要喝茶的哦'

  scope :published, -> { where("publish_status = ?", Settings.publish_status.published) }
end
