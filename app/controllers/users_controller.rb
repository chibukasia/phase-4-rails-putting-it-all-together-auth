class UsersController < ApplicationController
    # rescue_from ActiveRecord::RecordInvalid, with: :response_to_unprocessable_entity

    skip_before_action :authorize, only: [:create]
    def create 
        user = User.create!(user_params)
        session[:user_id] = user.id 
        render json: user, status: :created
    end 

    def show 
        user = User.find(session[:user_id]) 
        render json: user, status: :created
    end
    # Private methods 
    private 
    
    # permit user parameters 
    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    # # Method to catch invalid entries
    # def response_to_unprocessable_entity(err) 
    #     render json: {errors: err.record.errors.full_messages}, status: :unprocessable_entity
    # end
end
