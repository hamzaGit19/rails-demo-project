# frozen_string_literal: true

class Api::V1::ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :company
end
