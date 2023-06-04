class FollowsController < ApplicationController
    def index
        friends = User.find(params[:user_id]).friends
        render json: friends
    end

    def create
        user = User.find(params[:user_id])
        target = User.find(params[:id])
        follow = Follow.find_by(user: user, target: target)
        if !follow
            follow = Follow.new(user: user, target: target).save
            render json: {}, status: :created
        else
            render json: {}, status: :ok
        end
    end

    def destroy
        user = User.find(params[:user_id])
        target = User.find(params[:id])
        follow = Follow.find_by!(user: user, target: target)
        if follow
            follow.delete
        end
        render json: {}, status: :ok
    end

    def sleeps
        user = User.find(params[:user_id])
        start_week = Time.now.midnight - 1.week
        sleeps = Sleep.where(user_id: user.friends.pluck(:id)).
            where('sleep_at >= ?', start_week).
            order(duration: :asc)
        render json: sleeps
    end
end
