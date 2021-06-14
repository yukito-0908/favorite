class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_in_path_for(resource)
  case resource
  when User
    public_users_mypage_path
  when Admin
     admins_users_path
  end
end


  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin_admin_user
      new_admin_user_registaration_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :is_active ,:image,:instagram_id,
    :introduction])
  end

end
