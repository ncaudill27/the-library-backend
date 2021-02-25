class AuthenticationController < ApplicationController

  def login
    @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    if @user
      payload = {user_id: @user.id}
      token = encode_token(payload)
      render json: {user: UserSerializer.new(@user), auth_token: token, success: "#{@user.username} logged in!"}
    else
      render json: {failure: "Incorrect username or password! Try again."}
    end
  end

  def auto_login
    if session_user
      render json: UserSerializer.new(session_user)
    else
      render json: {failure: "No user logged in"}, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password)
  end
  
end