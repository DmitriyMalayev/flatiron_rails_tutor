## Dependencies (Gems/packages)
```
omniauth
omniauth-google-oauth2
dotenv-rails
```
## Configuration (environment variables/other stuff in config folder)
config/initializers/devise.rb
```
config.omniauth :google_oauth2, ENV['GOOGLE_OAUTH_CLIENT_ID'], ENV['GOOGLE_OAUTH_CLIENT_SECRET']
``` 
.env
```
GOOGLE_OAUTH_CLIENT_ID='your_id_goes_here'
GOOGLE_OAUTH_CLIENT_SECRET='your_secret_here'
```
add the .env file to the .gitignore file.

Also, we need to go create the application on the google developer platform and get the credentials from there. (As well as specify the authorized redirect URI to be http://localhost:3000/users/auth/google_oauth2/callback)

We had to configure the consent screen on the console. This required us to set the domain. We used this domain: lvh.me/ (an alias for localhost). After we'd configured the consent screen we were able to follow the instructions in the medium article below. 
#### Resources:
https://ktor.io/docs/guides-oauth.html

https://medium.com/@jenn.leigh.hansen/google-oauth2-for-rails-ba1bcfd1b863

## Database
add columns to user table for full_name, uid, email and avatar_url
## Models
add devise: :omniauthable, omniauth_providers: [:google_oauth_2]
```rb
  def self.from_google(uid:, email:, full_name:, avatar_url:)
    if user = User.find_by(email: email)
      user.update(uid: uid, full_name: full_name, avatar_url: avatar_url) unless user.uid.present?
      user
    else
      User.create(
        email: email,
        uid: uid,
        full_name: full_name,
        avatar_url: avatar_url,
        password: SecureRandom.hex
      )
    end
  end
  ```
  This will find the user if they already exist and update their account with info from google (for the case where someone uses OAuth to sign up when they already have an account with that email address)
## Views
add link to sign in with google (in our case Devise did that for us, but if we wanted to add a custom image we could use a syntax like this: https://stackoverflow.com/questions/43280001/rails-image-as-a-link/48630860#48630860)
```
<%= link_to(user_google_oauth2_omniauth_authorize_path) do %>
  <%= image_tag(my.image, class: 'product-image__img') if product.image.attached? %>
<% end %>
```
## Controllers
create a Users::OmniauthCallbacksController class in app/controllers/users/omniauth_callbacks_controller.rb
```rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_google(from_google_params)
    
    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
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
```
## Routes
```rb
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
```