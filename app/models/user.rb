class User < ApplicationRecord
    has_many :follows, -> { order(target_id: :desc) }
    has_many :friends, through: :follows, :source => :target
    has_many :sleeps

    validates :name, uniqueness: true
end
