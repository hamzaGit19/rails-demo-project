# frozen_string_literal: true

class Comment < ApplicationRecord
  paginates_per 5
  belongs_to :commentable, polymorphic: true

  validates :creator_id, presence: true
  validates :content, presence: true
end
