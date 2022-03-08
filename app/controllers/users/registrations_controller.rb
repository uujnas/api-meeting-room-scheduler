# The RegistrationController extends Devise::RegistrationController
# It is used for handling User CRUD.
## POST /users
## GET /users
## PUT/PATCH /users
## DELETE /users
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.active_for_authentication?

    register_failed
  end

  def register_success
    render json: {
      message: 'Sign up successfully',
      user: current_user
    }, status: :ok
  end

  def register_failed
    render json: {
      message: 'Sign up failed'
    }, status: :unprocessible_entity
  end
end
