# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false, default: ''
      t.string :company, null: false, default: ''
      t.string :phone
      t.string :email, null: false, default: ''
      t.string :country, null: false, default: ''
      t.string :referred_by
      t.string :compnay_phone

      t.timestamps
    end
  end
end
