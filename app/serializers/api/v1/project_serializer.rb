# frozen_string_literal: true

class Api::V1::Admin::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
end
