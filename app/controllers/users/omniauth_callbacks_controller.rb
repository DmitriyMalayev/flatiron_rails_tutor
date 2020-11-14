# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController  
#above must match what's in routes.rb  #It allows us to affect only the things we want and everything else will be left intact.     
    def google_oauth2
        user = User.from_google(from_google_params)

        if user.present?
            sign_out_all_scopes  
            #Sign out all active users or scopes. This helper is useful for signing out all roles in one click. 
            flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'  # t(translate) shorthand for I18n  
            sign_in_and_redirect user, event: :authentication 
        else
            flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
            redirect_to new_user_session_path
        end
    end



protected
    def after_omniauth_failure_path_for(_scope)
        new_user_session_path   
    end

    def after_sign_in_path_for(resource_or_scope)
        stored_location_for(resource_or_scope) || root_path
    end
# stored_location_for => Returns and delete (if it's navigational format) the url stored in the session for the given scope. 
# Useful for giving redirect backs after sign up. 


private

    def from_google_params
        @from_google_params ||= {
            uid: auth.uid,
            email: auth.info.email,
            full_name: auth.info.name,
            avatar_url: auth.info.image
        }
    end

    def auth
        @auth ||= request.env['omniauth.auth']
         
    end
end

# This request.env[‘omniauth.auth’] is a hash of user information sent back from the provider. 
# OmniAuth simply sets a special hash called the Authentication Hash on the Rack environment of a request to /auth/:provider/callback. 

#t (translate)
#Rails adds a t ( translate ) helper method to your views so that you do not need to spell out I18n. t all the time. 
#Additionally this helper will catch missing translations and wrap the resulting error message into a <span class="translation_missing"> .

# sign_in_and_redirect(resource_or_scope, *args) ⇒ Object
# Sign in a user and tries to redirect first to the stored location and then to the url specified by after_sign_in_path_for. 
# It accepts the same parameters as the sign_in method. 

# Passing :event => :authentication causes Warden (underlying Devise) to trigger any callbacks defined with:

# Warden::Manager.after_authentication do |user,auth,opts|
#   # Code triggered by authorization here, for example:
#   user.last_login = Time.now
# end
# If you're not using any after_authentication callbacks, and you're confident your libraries aren't either, 
# then it's not of any immediate use to you. Since it is an authentication event, I'd leave it in, now that you know what it's potentially useful for.





# uid => unique identifier 
# It is an identifier that marks that particular record as unique from every other record.


# stored_location_for 
# Provide the ability to store a location. 
# It's used to redirect back to a desired path after sign in. 
# Included by default in all controllers.

#store_location_for(resource_or_scope, location) ⇒ Object
# Stores the provided location to redirect the user after signing in.

#stored_location_for(resource_or_scope) ⇒ Object
# Returns and delete (if it's navigational format) the url stored in the session for the given scope.

# permalink#store_location_for(resource_or_scope, location) ⇒ Object
# Stores the provided location to redirect the user after signing in. Useful in combination with the `stored_location_for` helper.


# store_location_for(:user, dashboard_path)
# redirect_to user_facebook_omniauth_authorize_path

# permalink#stored_location_for(resource_or_scope) ⇒ Object
# Returns and delete (if it's navigational format) the url stored in the session for the given scope. Useful for giving redirect backs after sign up:

# Example:

# redirect_to stored_location_for(:user) || root_path