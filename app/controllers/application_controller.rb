class ApplicationController < ActionController::API

  private

  def logged_in?
    !!session_user
  end

  def require_login
    render json: {message: 'Please login'}, status: :unauthorized unless logged_in?
  end

  def encode_token(payload)
    JsonWebToken.sign(payload, key: ENV['SECRET_KEY_BASE'])
  end

  def session_user
    decoded_hash = decoded_token
    if !decoded_hash.empty?
      user_id = decoded_hash[:ok][:user_id]
      @user = User.find_by(id: user_id)
    else
      nil
    end
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ').last
      begin
        opts = { alg: 'HS256', key: ENV['SECRET_KEY_BASE']}
        JsonWebToken.verify(token, opts)
      rescue JWT::DecodeError
        []
      end
    end
  end

  def serialize(object)
    class_name = object.class.name
    serializer_name = class_name + "Serializer"
    serializer = Object.const_get(serializer_name)

    serializer.new(object)
  end

  def destroy_response(object)
    key = object.class.name.downcase + '_id'
    render json: { key => object.id.to_s }
  end
end
