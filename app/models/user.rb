# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable
  paginates_per 7
  mount_uploader :image, ImageUploader

  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true
  # validates :password_confirmation, presence: true
  validates :type, inclusion: { in: %w[Admin Manager Employee],
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
