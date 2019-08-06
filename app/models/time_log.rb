# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :project
  has_many :comments, as: :commentable
end
