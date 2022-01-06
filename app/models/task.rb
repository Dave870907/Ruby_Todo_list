class Task < ApplicationRecord
    belongs_to :user
    validates :start_time, :end_time, :title, :status, :order ,presence: true
    validate :time_order ,if: :time_present?
    

    private
    def time_present?
        start_time.presence && end_time.presence
    end
    def time_order 
        if end_time < start_time
            errors.add :end_time, 'Cannot earlier than start time!'
        end
    end

end
