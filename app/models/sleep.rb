class Sleep < ApplicationRecord
    belongs_to :user

    before_save :calculate_duration

    private
        def calculate_duration
            self.duration = wakeup_at - sleep_at
        end
end
