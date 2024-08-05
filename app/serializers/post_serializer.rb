# frozen_string_literal: true

class PostSerializer < Blueprinter::Base
  identifier :id

  fields :title, :text, :created_at

  field :created_at do |post|
    post.created_at.iso8601
  end

  field :user_nickname do |post, options|
    post.user.nickname
  end
end
