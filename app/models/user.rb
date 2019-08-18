# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :shared_secret
  attr_accessor :token_expires

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  paginates_per 7
  mount_uploader :image, ImageUploader

  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true
  # validates :password_confirmation, presence: true
  validates :type, presence: true, inclusion: { in: %w[Admin Manager Employee],
                                                message: '%{value} is not a valid type' }

  scope :managerUsers, -> { where.not type: %w[Admin] }

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

  def image?
    if image.eql? 'null'
      false
    else
      true
    end
  end

  def type?
    type
  end
end
