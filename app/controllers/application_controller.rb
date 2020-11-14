class ApplicationController < ActionController::Base # app/controllers/application_controller.rb
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    flash[:message] = "Not found"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :phone_number])
  end
end

#The ParameterSanitizer deals with permitting specific parameters values for each Devise scope in the application.
#The sanitizer knows about Devise default parameters (like password and password_confirmation for the `RegistrationsController`), and you can extend or change the permitted parameters list on your controllers.

# Permitting new parameters
# You can add new parameters to the permitted list using the permit method in a before_action method, for instance.

# class ApplicationController < ActionController::Base
#   before_action :configure_permitted_parameters, if: :devise_controller?

#   protected

#   def configure_permitted_parameters
#     # Permit the `subscribe_newsletter` parameter along with the other
#     # sign up parameters.
#     devise_parameter_sanitizer.permit(:sign_up, keys: [:subscribe_newsletter])
#   end
# end
# Using a block yields an ActionController::Parameters object so you can permit nested parameters and have more control over how the parameters are permitted in your controller.

# def configure_permitted_parameters
#   devise_parameter_sanitizer.permit(:sign_up) do |user|
#     user.permit(newsletter_preferences: [])
#   end
# end

# Private methods: are methods defined under the private keyword/method. Private methods can only be used within the class definition; they’re for internal usage. The only way to have external access to a private method is to call it within a public method. Also, private methods can not be called with an explicit receiver, the receiver is always implicitly self. Think of private methods as internal helper methods.

# Protected methods: a protected method is similar to a private method, with the addition that it can be called with, or without, an explicit receiver, but that receiver is always self (it’s defining class) or an object that inherits from self (ex: is_a?(self)).
