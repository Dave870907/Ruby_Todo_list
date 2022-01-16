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

    has_many :label_relations
    has_many :labels, through: :label_relations

    # 可以用 Post.tagge_with(tagname) 來找到文章
    def self.labelled_with(name)
        Label.find_by!(name: name).posts
    end
        
    # # tag_list 的 setter
    # def tag_list=(names)
    #     self.tags = names.split(',').map do |item|
    #       Tag.where(name: item.strip).first_or_create!
    #     end
    #   end
    
    def label_items
        labels.map(&:name).join(', ')
    end

    def label_items=(names)
        self.labels = names.map{|item|
            Label.where(name: item.strip).first_or_create! unless item.blank?}.compact!
    end

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
