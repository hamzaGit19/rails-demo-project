# frozen_string_literal: true

class AddCostToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :amount, :float
  end
end
