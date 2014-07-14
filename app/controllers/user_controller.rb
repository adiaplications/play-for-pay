class UserController < ApplicationController

  layout 'admin'

  #before_action :confirm_logged_in, :except => [:set_email, :set_password, :sync]
  helper_method :sort_column, :sort_direction

  def create_new_user(params)
    @user = User.new(:email                 => params[:email],
                     :password              => params[:password], # legacy
                     :password_confirmation => params[:password],
                     :country               => params[:country],
                     :number_of_downloads   => 0,
                     :total_earnings        => 0.0,
                     :active                => true,
                     :created_on            => Time.now,
                     :last_visited_at       => Time.now,
                     :last_faild_attempt    => Time.now,
                     :failed_attempts       => 0)
  end

  #registers mobile
  def set_email
    #return head(404) if !request.xhr? # Hi crawler, Bye crawler
    return render :json => {:errors => "server errors"} if params["email"].blank?
    @email = User.unique_gmail_email(params[:email].strip)
    @user = User.find_by_email(@email) if @email
    if (@user && @user.active?)
      result = {:existing => "existing user"}    #if params[:email].blank? render :json => {:exists => User.where(:email => params[:email]).exists?}
      if !@user.password.blank?
        result = {:passed => true, :user_id => @user.id }
      end
      return render :json => result
    else
      return render :json =>{:errors => "You're already registered. Please try to sign in." }
    end
  end

  def set_password
    #return head(404) if !request.xhr? # Hi crawler, Bye crawler
    return render :json => {:errors => "Blank email address"} if params["email"].blank?
    return render :json => {:errors => "Blank password"} if params["password"].blank?
    #@password = params[:password]
    #@answer = {}
    @extra_params = {'user_agent' => request.user_agent}
    user = @user || create_new_user(params)
    if user.valid?
      user.save!
      #create_cookie_for_user!(user)
      return render :json => {
          :passed => true,
          :user_id => user.id,
          :user_email => user.email,
          :country => user.country,
          :total_earnings => user.total_earnings} if user
    else
      return render :json =>{:errors => user.errors.full_messages.first }
    end
  end

  def sync
    #return  head(404) if (request.user_agent !~ /iPhone/)
    return render :json => {:errors => "Blank email address"} if params["email"].blank?
    return render :json => {:errors => "Blank password"} if params["password"].blank?
    @email = User.unique_gmail_email(params[:email].strip)
    @user = User.find_by_email(@email) if @email
    if !@user
      #return render :json => {:errors => "Please confirm your registration by clicking on the in the link we've sent to #{params[:email]} "} if params[:approved]
      return render :json => {:errors => "dAccount Problem: Please double-check your login information and try again."}
    elsif !@user.authenticate?(params[:password])
      return render :json => {:errors => "Account Problem: Please double-check your login information and try again."}
    end

    #create_cookie_for_user!(@user)
    #device_kinds = APN::Device.find_all_by_user_id(@user.id).group_by(&:kind)
    return render :json => {
        #:user_remember_token => @user.remember_token,
        :passed => true,
        :user_id => @user.id,
        :user_email => @user.email,
        :country => user.country,
        :total_earnings => user.total_earnings}
  end

end
