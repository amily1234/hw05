class UsersController < ApplicationController
  def index
    @users = User.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: I18n.t(:create_account_success_template)
    else
      render :new
    end
  end

  def edit
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])

		if @user.update(user_params)
		  redirect_to users_path, notice: "使用者更新成功!"
		else
		  render :edit
		end
	end

  def destroy
		@user = User.find_by(id: params[:id])
		@user.destroy if @user
		redirect_to users_path, notice: "使用者資料已刪除!"
	end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)      
  end
end
