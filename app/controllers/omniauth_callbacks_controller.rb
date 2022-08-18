class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"]) #Hàm callback from_omniauth này sẽ viết ở model, input chính là thông tin của tài khoản facebook 
  
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #Trong trường hợp tài khoản inactived thì sẽ quăng exception ở đây
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        redirect_to new_user_registration_url
      end
    end
end