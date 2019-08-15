# frozen_string_literal: true

class Client < ApplicationRecord
  paginates_per 7
  has_many :projects, dependent: :delete_all

  validates :email, uniqueness: true
  validates :name, presence: true
end
