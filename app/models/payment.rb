# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per 5

  belongs_to :project
  has_many :comments, as: :commentable
end
