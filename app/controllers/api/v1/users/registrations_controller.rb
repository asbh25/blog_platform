# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        include RackSessionsFix

        respond_to :json

        private

        def respond_with(_current_user, _opts = {})
          if resource.persisted?
            render_success_response
          else
            render_failure_response
          end
        end

        def render_success_response
          render json: {
            status: { code: 200, message: 'Signed up successfully.' },
            data: UserSerializer.render_as_hash(resource)
          }
        end

        def render_failure_response
          render json: {
            status: {
              message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"
            }
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
