class RegistrationsController < Devise::RegistrationsController
  
  def new
    build_resource({})
    resource.build_image
    respond_with self.resource
  end

  

  protected
  # def after_update_path_for resource
  #   edit_user_registration_path
  # end

  def after_sign_up_path_for(resource)
    root_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :dob, :company_name, :avatar, image_attributes: [:id, :avatar, :imageable_type, :imageable_id, :_destroy])
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :dob, :company_name, :avatar, image_attributes: [:id, :avatar, :imageable_type, :imageable_id, :_destroy])
  end

  def update_resource(resource, params)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end