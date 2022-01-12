class UsersController < ApplicationController

    before_action :find_user, only: %i[edit show]

    def idnex 
        @users = User.all
    end

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to '/tasks' , notice: t('notice.new')
        else 
            render :new
        end
    end

    private
    def find_user 
        @user = User.find_by(id: params[:id])
    end

    def user_params
        params.require(:user).permit(:user_name, :email, :password)
    end

end
