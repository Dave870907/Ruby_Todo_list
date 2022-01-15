class User < ApplicationRecord
    has_many :tasks, :dependent => :delete_all
    validates :user_name, :email, :password ,presence: true
    has_secure_password

      # Admin deletion settings
    scope :admin_count, -> { where(admin: true).count}
    
    before_save :check_admin_count
    def check_admin_count
        if self.admin_changed?(from: true, to: false) && User.admin_count == 1
            errors.add :admin, message: I18n.t('notice.no_admin')
            throw :abort
        end
    end
end
