# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :text, presence: true, length: { maximum: 150 }

  scope :filter_by_user, ->(user_id) { where(user_id: user_id) if user_id.present? }

  def self.filter(params)
    posts = all
    posts = posts.filter_by_user(params[:user_id])
  end

  def self.default_per_page
    20
  end
end
