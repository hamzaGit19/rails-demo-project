# frozen_string_literal: true

class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :content
end
