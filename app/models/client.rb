# frozen_string_literal: true

class Client < ApplicationRecord
  paginates_per 7
  has_many :projects, dependent: :delete_all

  validates :email, uniqueness: true
  validates :name, presence: true

  def self.apply_filter(params)
    @clients = Client.all # creates an anonymous scope
    @clients = @clients.where("name like ?", "#{params[:name]}%") if params[:name].present?
    @clients = @clients.where(params[:email]) if params[:email].present?
    @clients = @clients.where("company like ?", "#{params[:company]}%") if params[:company].present?
    @clients
  end
end
