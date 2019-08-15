# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per 5

  belongs_to :project
  has_many :comments, as: :commentable

  validates :creator_id, presence: true
  validates :amount, presence: true, numericality: true
end
