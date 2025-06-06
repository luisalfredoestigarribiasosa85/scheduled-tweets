class OmniauthCallbacksController < ApplicationController
  def twitter
    # First check if user is signed in
    if Current.user
      # User is signed in, associate the Twitter account
      twitter_account = Current.user.twitter_accounts.find_or_initialize_by(username: auth.info.nickname)
      twitter_account.update!(
        name: auth.info.name,
        image: auth.info.image,
        token: auth.credentials.token,
        secret: auth.credentials.secret
      )

      redirect_to root_path, notice: "Successfully connected your Twitter account!"
    else
      # User is not signed in, redirect to sign in page with a message
      session[:twitter_oauth] = {
        uid: auth.uid,
        name: auth.info.name,
        username: auth.info.nickname,
        image: auth.info.image,
        token: auth.credentials.token,
        secret: auth.credentials.secret
      }

      redirect_to sign_in_path, alert: "Please sign in to connect your Twitter account."
    end
  rescue => e
    Rails.logger.error "Twitter OAuth error: #{e.message}"
    redirect_to root_path, alert: "Something went wrong while connecting to Twitter. Please try again."
  end

  def failure
    redirect_to root_path, alert: "Failed to authenticate with Twitter. Please try again."
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
