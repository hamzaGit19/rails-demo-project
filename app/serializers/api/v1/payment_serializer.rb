class Api::V1::PaymentSerializer < ActiveModel::Serializer
  attributes :id, :amount
end
