# frozen_string_literal: true

# Password_Controller
class Doctor < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_many :patients, through: :appointments

  scope :general_practice, -> { where(specialty: 'General Practice') }

  def fullname
    user ? user.fullname : nil
  end

  def self.family_medicine
    where(specialty: 'Family Medicine')
  end

  def self.specialties
    select(:specialty).distinct.order(specialty: :asc)
  end

  def self.by_specialty(specialty)
    where(specialty: specialty)
  end
end
