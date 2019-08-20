# frozen_string_literal: true

class Api::V1::CommentsSerializer < ActiveModel::Serializer
  attributes :id, :content
end
