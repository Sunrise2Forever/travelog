class SessionsController < Devise::SessionsController

	# GET /resource/sign_in
  def new
  	self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end


	# POST /resource/sign_in
  def create
  	self.resource = warden.authenticate!(auth_options)
    #set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

end