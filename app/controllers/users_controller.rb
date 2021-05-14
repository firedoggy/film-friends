class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            log_in(@user)
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        #redirect_if_not_logged_in
        @user = User.find_by_id(params[:id])
        if @user
            @reviews = Review.by_user(@user)
        else
            redirect_to '/'
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :password)
    end

end
