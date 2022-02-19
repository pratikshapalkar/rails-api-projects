# frozen_string_literal: true

# schema information
# Table name = Users



class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,
  devise :database_authenticatable, :validatable, :confirmable

  before_save -> { skip_confirmation! }

  
  # Associations
  belongs_to :product
end
