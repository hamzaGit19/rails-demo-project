# frozen_string_literal: true

class AddClientToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :client, index: true
  end
end
