class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      # redirect_back_or root_path
      if user.admin?
        redirect_to users_path
      else
        redirect_to user
      end
    else
      flash.now[:danger] = 'Wrong email or password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end
end
