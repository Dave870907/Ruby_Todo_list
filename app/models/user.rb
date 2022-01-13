class User < ApplicationRecord
    has_many :tasks
    validates :user_name, :email, :password ,presence: true
    has_secure_password
end
