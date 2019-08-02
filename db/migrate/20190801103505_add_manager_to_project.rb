# frozen_string_literal: true

class AddManagerToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :manager, index: true
  end
end
