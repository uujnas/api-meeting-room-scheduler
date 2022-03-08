# The SessionController extends Devise::SessionController.
##
## It is used for User Login and Log out.
## POST /users/sign_in
## DELETE /users/sign_out
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    render json: { message: 'You are successfully logged in' }, status: :ok
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'You are successfully logged out' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failed, Try again' }, status: :unauthorized
  end
end
