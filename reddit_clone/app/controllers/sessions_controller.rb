class SessionsController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username],
                                        params[:user][:password])
        if @user 
            login(@user)
            #redirect_to links_url
        else  
            flash.now[:errors] = ["wrong username or password"]
            render :new
        end
    end

    def destroy
        logout 
        session[:session_token] = nil
        redirect_to new_session_url
    end

end