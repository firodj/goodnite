class User < ApplicationRecord
    has_many :follows, -> { order(target_id: :asc) }
    has_many :friends, through: :follows, :source => :target
    has_many :sleeps

    validates :name, uniqueness: true

    def as_json(options = nil)
        super({ only: [:id, :name] }.merge(options || {}))
    end
end
