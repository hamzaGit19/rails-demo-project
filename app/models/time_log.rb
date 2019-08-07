# frozen_string_literal: true

class TimeLog < ApplicationRecord
  paginates_per 5
  belongs_to :project
  has_many :comments, as: :commentable
end
