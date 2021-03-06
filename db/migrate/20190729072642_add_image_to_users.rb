# frozen_string_literal: true

class AddImageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :string, default: 'null'
  end
end
