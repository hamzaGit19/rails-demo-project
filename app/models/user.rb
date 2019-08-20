# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Filterable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #  :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  paginates_per 7
  mount_uploader :image, ImageUploader

  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true
  # validates :password_confirmation, presence: true
  validates :type, presence: true, inclusion: { in: %w[Admin Manager Employee],
                                                message: '%{value} is not a valid type' }

  scope :managerUsers, -> { where.not type: %w[Admin] }
  scope :user_name, ->(name) { where('name like ?', "#{name}%") }
  scope :email, ->(email) { where email: email }

  def admin?
    instance_of?(Admin)
  end

  def manager?
    instance_of?(Manager)
  end

  def client?
    instance_of?(Client)
  end

  def employee?
    instance_of?(Employee)
  end

  def type?
    type
  end

  def self.apply_filter(params)
    byebug
    @users = User.where(nil) # creates an anonymous scope
    @users = @users.user_name(params[:name]) if params[:name].present?
    @users = @users.email(params[:email]) if params[:email].present?
    @users
  end
end
