class FollowsController < ApplicationController
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
end
