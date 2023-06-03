class User < ApplicationRecord
    has_many :events
    has_many :follows
    has_many :friends, through: :follows, :source => :target
end
