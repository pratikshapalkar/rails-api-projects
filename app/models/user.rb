# frozen_string_literal: true
# --Schema information
#  Table name = users
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  sport_id               :bigint
#  email                  :string
#  phone                  :string
#  is_active              :boolean
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
# 
class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  # associations
  has_many :achievements, dependent: :destroy
  has_many :posts, dependent: :destroy
  # allows to reference the user roles with strings, but store them in the database as integers.
  enum role: [:user, :admin]
  # validations
  validates :email, uniqueness: { case_sensitive: false }, presence: true
end
