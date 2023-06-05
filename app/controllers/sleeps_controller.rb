class SleepsController < ApplicationController
    def index
        user = User.find(params[:user_id])
        sleeps = user.sleeps.order('sleep_at ASC')
        render json: sleeps.as_json({ only: [:wakeup_at, :sleep_at, :duration ]})
    end

    def create
        user = User.find(params[:user_id])
        sleep_record = user.sleeps.create!(sleep_params)
        render json: { id: sleep_record.id }, status: :created
    end

    def follows
        user = User.find(params[:user_id])
        start_week = Time.now.midnight - 1.week
        sleeps = Sleep.includes(:user).where(user_id: user.friends.pluck(:id)).
            where('sleep_at >= ?', start_week).
            order(duration: :asc)
        render json: sleeps.as_json({ include: { user: { only: [:id, :name ] } } })
    end

    private
        def sleep_params
            params.require(:sleep).permit(:sleep_at, :wakeup_at)
        end
end
