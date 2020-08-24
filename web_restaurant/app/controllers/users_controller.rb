class UsersController < ApplicationController
    skip_before_action :only_signed_in, only: [:new, :create, :confirme, :index]
def new
    @user = User.new
end
def create
    user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    if @user.valid?
        @user.save
        UserMailer.confirm(@user).deliver_now
        redirect_to new_user_path, success: 'votre compte a bien ete crée, vous devriez recevoire un email de confirmation'
        
    else
        render 'new'
    end
end
def confirm
    @user = User.find(params[:id])
    if @user.confirmation_token == params[:token]
        @user.update_attributes(confirmed: true, confirmation_token: nil)
        @user.save(validate: false)
        session[:auth] = @user.to_session
        redirect_to profil_path, success: 'votre compte a bien ete confirmé'
        else
            redirect_to new_user_path, danger: 'se token la ne semble pas valide'
    end
end
def edit 
    @user = User.find(session[:auth]['id'])
end  
def update 

end
end

