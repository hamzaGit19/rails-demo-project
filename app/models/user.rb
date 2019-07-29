# frozen_string_literal: true

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable
  paginates_per 7
  mount_uploader :image, ImageUploader

  scope :managerUsers, ->() { where.not type: %w(Admin) }

  def admin?
    instance_of?(Admin)
  end

  def manager?
    instance_of?(Manager)
  end

  def client?
    instance_of?(Client)
  end

  def image?
    if self.image.eql? "null"
      return false
    else
      return true
    end
  end

  def type?
    type
  end
end
