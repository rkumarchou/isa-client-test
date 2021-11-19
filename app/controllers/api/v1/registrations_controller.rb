module Api
  module V1
    class RegistrationsController < ApplicationController
      # POST api/v1/sign_up
      def create
        user = User.new(sign_up_params)
        user.password = params[:password]

        if user.save
          render json: { user: ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer), message: 'You sign up successfully' }
        else
          render json: { error: user.errors.full_messages.first }
        end
      end

      private

      def sign_up_params
        params.permit(:first_name, :last_name, :email)
      end
    end
  end
end
