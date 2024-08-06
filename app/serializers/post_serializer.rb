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

class PostSerializer < Blueprinter::Base
  identifier :id

  fields :title, :text, :created_at

  field :created_at do |post|
    post.created_at.iso8601
  end

  field :user_nickname do |post, _options|
    post.user.nickname
  end
end
