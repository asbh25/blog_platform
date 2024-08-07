# frozen_string_literal: true

class AddNicknameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nickname, :string
  end
end
