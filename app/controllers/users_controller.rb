class UsersController < ApplicationController
  def index
		@users = User.all
	end
  
  def new
    @user = User.new
  end

  def create
    # render plain: "Thanks!"
    # render plain: params[:user]  
    #打印 {"email"=>"exite@gmail.com", "password"=>"123", "password_confirmation"=>"12"}

    # @user = User.new(params[:user])
    # User.new({email: "other.goto.com", password: "password", password_confirmation: "password"})

    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully create account!"
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
    params.require(:user).permit(:email, :password, :password_confirmation, :role_id)      
  end

end