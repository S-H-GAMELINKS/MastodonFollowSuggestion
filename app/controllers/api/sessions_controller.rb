class Api::SessionsController < ActionController::API

    def user_session
        if user_signed_in?
            @user = current_user
        else
            @user = nil
        end
    
        render json: @user
    end
end