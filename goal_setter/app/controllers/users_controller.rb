class UsersController < ApplicationController

    def index
        @users = User.all
        render :index
    end

    def new
        @user = User.new
        render :new
    end

    def show
        @user = User.find(params[:id])
        render :show
    end



    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end