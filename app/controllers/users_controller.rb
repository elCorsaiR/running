class UsersController < ApplicationController
  before_action :signed_in_user, except: [:show]
  before_action :admin_user, only: [:index, :new, :create, :destroy]
  # before_action :correct_user, only: [:show]
  def index
    @users = User.clients.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.password = 'foobar'
    @user.password_confirmation = 'foobar'
    if @user.save
      flash[:success] = 'Success'
      redirect_to edit_user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by_idsolt params[:id]
    render layout: 'report'
  end

  def edit
    @user = User.find_by_idsolt params[:id]
  end

  def update
    @user = User.find_by_idsolt params[:id]
    if @user.update_attributes(user_params)
      flash[:success] = 'Success'
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :password,
                                 :password_confirmation, :updating_password, :admin, :file, :published)
  end

  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user) and !current_user.admin?
      redirect_to(current_user)
    end
  end

end
