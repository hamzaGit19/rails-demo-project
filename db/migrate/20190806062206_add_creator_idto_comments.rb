# frozen_string_literal: true

class AddCreatorIdtoComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :creator_id, :integer, null: false, default: -1
  end
end
