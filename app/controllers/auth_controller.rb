class AuthController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

end
