# frozen_string_literal: true

class Client < ApplicationRecord
  paginates_per 7
  has_many :projects, dependent: :delete_all

  validates :email, uniqueness: true
  validates :name, presence: true

  scope :user_name, ->(name) { where('name like ?', "#{name}%") }
  scope :email, ->(email) { where email: email }
  scope :company, ->(company) { where('company like ?', "#{company}%") }

  def self.apply_filter(params)
    @clients = Client.where(nil) # creates an anonymous scope
    @clients = @clients.user_name(params[:name]) if params[:name].present?
    @clients = @clients.email(params[:email]) if params[:email].present?
    @clients = @clients.email(params[:company]) if params[:company].present?
    @clients
  end
end
