class UserDownload < ActiveRecord::Base
  belongs_to :user

  layout 'admin'

  before_action :confirm_logged_in, :except => [:show_ads_by_country]

  helper_method :sort_column, :sort_direction
end
