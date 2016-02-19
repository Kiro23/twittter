class SessionsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email].downcase)
    if not @user.nil? and @user.authenticate(params[:session][:password])
      sign_in @user 
      redirect_to @user
    else
      flash[:danger] = "Неверное имя или пароль"
      render 'new' 
    end
  end
  
  def destroy 
    sign_out
    flash[:info] = "Вы успешно вышли из страницы!"
    redirect_to root_path
  end
  
end


