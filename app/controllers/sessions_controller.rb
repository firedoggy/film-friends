class SessionsController < ApplicationController

    def home
    end

    def create
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
          log_in(user)
          redirect_to user_path(user)
        else
          flash[:message] = "Incorrect login info, please try again"
          redirect_to '/login'
        end
    end

    def destroy
        session.clear
        redirect_to root_path
    end
    
    def google
       user = User.from_omniauth(auth)
       if user.valid?
            log_in(user)
            redirect_to user_path(user)
       else
            redirect_to '/login'
       end
    end

    private

    def auth
        request.env['omniauth.auth']
    end

end