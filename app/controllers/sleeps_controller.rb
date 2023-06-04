class SleepsController < ApplicationController
    def index

    end

    def create
        user = User.find(params[:user_id])
        sleep_record = Sleep.new(sleep_params)
        sleep_record.user = user
        sleep_record.save
        render json: { id: sleep_record.id }, status: :created
    end

    private
        def sleep_params
            params.permit(:sleep_at, :wakeup_at)
        end
end
