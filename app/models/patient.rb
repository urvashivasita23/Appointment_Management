# frozen_string_literal: true

# Password_Controller
class Patient < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_many :doctors, through: :appointments
  accepts_nested_attributes_for :user

  def fullname
    user ? user.fullname : nil
  end
end
