# frozen_string_literal: true

class Api::V1::Admin::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :status
end
