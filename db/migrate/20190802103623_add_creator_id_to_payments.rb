# frozen_string_literal: true

class AddCreatorIdToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :creator_id, :integer
  end
end
