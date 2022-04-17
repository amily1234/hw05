class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: I18n.t(:login_success_template)
    else
      flash[:alert] = I18n.t(:Invalid_email_account_or_password_template)
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path, notice: I18n.t(:logout_template)
  end
end
