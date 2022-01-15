class Label < ApplicationRecord
    has_many :label_relations
    has_many :tasks, through: :label_relations
end
