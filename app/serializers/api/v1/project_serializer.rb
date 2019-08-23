# frozen_string_literal: true

class Api::V1::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :payments, :comments, :time_logs

  def payments
    object.payments.last(5).map do |payment|
      Api::V1::PaymentSerializer.new(payment, scope: scope, root: false, project: object)
    end
  end

  def comments
    object.comments.last(5).map do |comment|
      Api::V1::CommentSerializer.new(comment, scope: scope, root: false, project: object)
    end
  end

  def time_logs
    object.time_logs.last(5).map do |time_log|
      Api::V1::TimeLogSerializer.new(time_log, scope: scope, root: false, project: object)
    end
  end
end
