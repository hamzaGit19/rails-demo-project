# frozen_string_literal: true

class Api::V1::Admin::ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :company
end
