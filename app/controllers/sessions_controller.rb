class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id

      # Check for pending Twitter OAuth data
      if session[:twitter_oauth].present?
        twitter_data = session.delete(:twitter_oauth)

        # Associate the Twitter account with the user
        twitter_account = user.twitter_accounts.find_or_initialize_by(username: twitter_data['username'])
        twitter_account.update!(
          name: twitter_data['name'],
          image: twitter_data['image'],
          token: twitter_data['token'],
          secret: twitter_data['secret']
        )

        redirect_to root_path, notice: "Logged in and connected to Twitter successfully!"
      else
        redirect_to root_path, notice: "Logged in successfully"
      end
    else
      flash[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end
end
