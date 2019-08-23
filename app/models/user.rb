# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  paginates_per 7
  mount_uploader :image, ImageUploader

  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true
  # validates :password_confirmation, presence: true
  validates :type, presence: true, inclusion: { in: %w[Admin Manager Employee],
                                                message: "%{value} is not a valid type" }

  scope :manager_filter, -> { where.not type: %w[Admin] }

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
    @users = User.all # creates an anonymous scope
    @users = @users.where("name like ?", "#{params[:name]}%") if params[:name].present?
    @users = @users.where(where email: params[:email]) if params[:email].present?
    @users
  end
end
