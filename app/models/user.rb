# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
    paginates_per 1

  def admin?
    instance_of?(Admin)
  end

  def manager?
    instance_of?(Manager)
  end

  def client?
    instance_of?(Client)
  end

  def type?
    self.type
  end
end
