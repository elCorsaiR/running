class UsersController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user, only: [:index, :new, :create, :destroy]
  before_action :correct_user, only: [:show]
  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.password = 'foobae'
    @user.password_confirmation = 'foobae'
    if @user.save
      flash[:success] = 'Success'
      redirect_to users_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find params[:id]
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :updating_password, :admin, :file)
  end

  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user) and !current_user.admin?
      redirect_to(current_user)
    end
  end

end
