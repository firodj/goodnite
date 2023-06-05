class Sleep < ApplicationRecord
    belongs_to :user

    before_save :calculate_duration

    validates_comparison_of :wakeup_at, greater_than: :sleep_at
    validate :no_overlap

    scope :time_overlap, -> (sleep_at, wakeup_at) {
        wakeup_at = Time.parse(wakeup_at) if wakeup_at.is_a? String
        sleep_at = Time.parse(sleep_at) if sleep_at.is_a? String

        where('sleep_at < ?', wakeup_at).
        where('? < wakeup_at', sleep_at)
    }

    def as_json(options = nil)
        super({ only: [:sleep_at, :wakeup_at, :duration] }.merge(options || {}))
    end


    private
        def calculate_duration
            self.duration = wakeup_at - sleep_at
        end

        def no_overlap
            errors.add(:sleep_at, "sleep_at overlap") if
            Sleep.time_overlap(self.sleep_at, self.wakeup_at).
                where(user_id: self.user_id).
                where.not(id: self.id).
                exists?
        end
end
