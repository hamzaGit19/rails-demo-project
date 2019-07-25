# frozen_string_literal: true

class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :boolean, default: false
  end
end
