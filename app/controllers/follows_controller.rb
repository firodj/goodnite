class FollowsController < ApplicationController
    def index
        friends = User.find(params[:user_id]).friends
        render json: friends
    end

    def create
        user = User.find(params[:user_id])
        target = User.find(params[:id])
        if user.id == target.id
            render json: { error: "cannot follow self" }, status: :bad_request
        else
            follow = Follow.find_by(user: user, target: target)
            if !follow
                follow = Follow.new(user: user, target: target).save
                render json: {}, status: :created
            else
                render json: {}, status: :ok
            end
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
