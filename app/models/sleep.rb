class Sleep < ApplicationRecord
    belongs_to :user

    before_save :calculate_duration

    validates_comparison_of :wakeup_at, greater_than: :sleep_at

    def as_json(options = nil)
        super({ only: [:sleep_at, :wakeup_at, :duration] }.merge(options || {}))
    end

    private
        def calculate_duration
            self.duration = wakeup_at - sleep_at
        end
end
