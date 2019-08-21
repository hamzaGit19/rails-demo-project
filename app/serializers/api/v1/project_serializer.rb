# frozen_string_literal: true

class Api::V1::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
end
