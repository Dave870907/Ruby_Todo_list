class Admin::UsersController < ApplicationController

    before_action :find_user, only: %i[edit show destroy update]

    def index 
        if !current_user.admin?
            redirect_to tasks_path , notice: t('notice.not_admin')
        end
        @users = User.order(id: :ASC).page(params[:page]).per(9)
    end

    def new
        @user = User.new
    end
    
    def show
        
        @q = @user.tasks.ransack(params[:q])
        @tasks = @q.result.order('id ASC').page(params[:page]).per(9)

    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to admin_root_path , notice: t('notice.new')
        else 
            render :new
        end
    end

    def edit 
    end
    
    def destroy
        @user.destroy
        redirect_to admin_root_path, notice: I18n.t('notice.delete')
    end

    def update
        
        if @user.update(admin_params)
            redirect_to admin_root_path
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

    def admin_params
        params.require(:user).permit(:user_name, :email, :password, :admin)
    end

end
