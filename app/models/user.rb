class User < ApplicationRecord
    has_many :follows
    has_many :friends, through: :follows, :source => :target

    validates :name, uniqueness: true
end
