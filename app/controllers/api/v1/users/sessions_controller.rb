# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        include RackSessionsFix

        respond_to :json

        private

        def respond_with(current_user, _opts = {})
          render json: {
            status: {
              code: 200, message: 'Logged in successfully.',
              data: { user: UserSerializer.render_as_hash(current_user) }
            }
          }, status: :ok
        end

        def respond_to_on_destroy
          current_user = find_current_user_from_token
          if current_user
            render_logged_out_success
          else
            render_no_active_session
          end
        end

        def find_current_user_from_token
          return unless request.headers['Authorization'].present?

          jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                                   Rails.application.credentials.devise_jwt_secret_key!).first
          User.find_by(id: jwt_payload['sub'])
        end

        def render_logged_out_success
          render json: {
            status: 200,
            message: 'Logged out successfully.'
          }, status: :ok
        end

        def render_no_active_session
          render json: {
            status: 401,
            message: "Couldn't find an active session."
          }, status: :unauthorized
        end
      end
    end
  end
end
