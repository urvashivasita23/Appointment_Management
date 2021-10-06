# frozen_string_literal: true

# Password_Controller
class User < ApplicationRecord
  has_secure_password

  has_one :patient
  has_one :doctor

  before_validation :capitalized_name

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true, format: { without: /[0-9]/, message: 'Numbers are not allowed.' }
  validates :lastname, presence: true, format: { without: /[0-9]/, message: 'Numbers are not allowed.' }

  def fullname
    firstname + ' ' + lastname
  end

  def capitalized_name
    self.firstname = firstname.titleize
    self.lastname = lastname.titleize
  end

  def self.patients
    joins(:patient) # for postgres
    # joins(:patient).where("user_id") # for sqlite3
  end

  def self.doctors
    joins(:doctor) # for postgres
    # joins(:doctor).where("user_id") # for sqlite3
  end
end
