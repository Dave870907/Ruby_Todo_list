class SessionsController < ApplicationController

  before_action :find_session_user , only: %i[create delete]

  def new
  end
# 使用者登入
  def create
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = I18n.t('notice.login')
      redirect_to tasks_path(@user)
    else
      redirect_to login_path, notice: I18n.t('notice.login_fail')

    end
  end
# 使用者登出
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t('notice.logout')
  end

  private

  def find_session_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end
  

end
