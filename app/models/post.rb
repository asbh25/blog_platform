# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  text       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :text, presence: true, length: { maximum: 150 }

  scope :filter_by_user, ->(user_id) { where(user_id:) if user_id.present? }

  def self.filter(params)
    posts = all
    posts.filter_by_user(params[:user_id])
  end

  def self.default_per_page
    20
  end
end
