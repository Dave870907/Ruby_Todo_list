class User < ApplicationRecord
    has_many :tasks, :dependent => :delete_all
    validates :user_name, :email, :password ,presence: true
    has_secure_password

      # Admin deletion settings
    scope :all_admin, -> { where(admin: true)}
    
    before_save :check_admin_count
    def check_admin_count
        if self.admin_changed?(from: true, to: false) && User.all_admin.count == 1
            errors.add :admin, message: I18n.t('notice.no_admin')
            throw :abort
        end
    end
end
