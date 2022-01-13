class UsersController < ApplicationController

    before_action :find_user, only: %i[edit show]

    def index 
        @users = User.all
        @users = @users.order(id: :ASC).page(params[:page]).per(9)
    end

    def new
        @user = User.new
    end
    
    def show
    
        @q = User.find(params[:id]).tasks.ransack(params[:q])
        @tasks = @q.result
        @tasks = @tasks.order('id ASC').page(params[:page]).per(9)

    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to admin_path , notice: t('notice.new')
        else 
            render :new
        end
    end

    def edit
        @user = User.find_by(id: params[:id])
    end
    
    def destroy
        @user = User.find_by(id: params[:id])
        @tasks = @user.tasks
        @tasks.destroy_all if @tasks
        @user.destroy if @user
        
        redirect_to admin_path, notice: I18n.t('notice.delete')
    end


    def update
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            redirect_to admin_path
            flash[:notice] = I18n.t('notice.update')
        else
            flash[:notice] = @user.errors.full_messages.to_sentence
            render :edit
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
