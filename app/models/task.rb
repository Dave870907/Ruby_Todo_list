class Task < ApplicationRecord
    include AASM

    aasm column: :status do 
        state :pending  , initial: true
        state :process , :finish
    
    event :do_it do
        transitions from: :pending, to: :process
    end

    event :finish_it do
        transitions from: :process, to: :finish
    end
    end
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
