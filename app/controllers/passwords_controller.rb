class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]


  def new_registration
    @user = User.new
  end
  def create_registration
    @user = User.new(user_params)
  
    if @user.save
      redirect_to new_session_path, notice: "Tài khoản đã được tạo thành công! Vui lòng đăng nhập."
    else
      flash.now[:alert] = "Đã xảy ra lỗi. Vui lòng kiểm tra lại thông tin đăng ký."
      render :new_registration, status: :unprocessable_entity
    end
  end
  
  
  

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: "Password has been reset."
    else
      redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end

    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end
end
