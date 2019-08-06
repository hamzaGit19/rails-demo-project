# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :project
  has_many :comments, as: :commentable
end
