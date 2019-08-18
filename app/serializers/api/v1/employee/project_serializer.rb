# frozen_string_literal: true

class Api::V1::Employee::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name
end
