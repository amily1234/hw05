class UsersController < ApplicationController
  def index
    @users = User.includes(:tasks)
  end
  
end
