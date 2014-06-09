class AdsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in, :except => [:show_ads_by_country]

  helper_method :sort_column, :sort_direction

  def index
    @ads = Ad.order(sort_column + " " + sort_direction)
  end

  def show
    @ad = Ad.find(params[:id])
    # @campaign = Campaign.find(params[:campaign_id])
  end

  def new
    @ads = Ad.new
    # @campaign_names = Campaign.all.select(['name'])
    @campaings = Campaign.sorted
  end

  def create
    # Instantiate a new object using form parameters
    @ad = Ad.new(ad_params)
    # Save the object
    if @ad.save
      # If save succeeds, redirect to the index action
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      @campaings = Campaign.sorted
      render('new')
    end
  end

  def edit
    @ad = Ad.find(params[:id])
    @campaings = Campaign.sorted
  end

  def update
# Find an existing object using form parameters
    @ad = Ad.find(params[:id])
# Update the object
    if @ad.update_attributes(ad_params)
# If update succeeds, redirect to the index action
      flash[:notice] = "Ad updated successfully."
      redirect_to(:action => 'show', :id => @ad.id)
    else
# If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    ad = Ad.find(params[:id]).destroy
    flash[:notice] = "Ad '#{ad.campaign_id}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  def show_campaign_ads
    campaign = Campaign.find(params[:id])
    @ads = campaign.ads
    render('index')
    # @campaign = Campaign.find(params[:campaign_id])
  end


  def show_ads_by_country
    result = []
    @ads = Ad.get_by_country(params[:user_country]).sorted
    @ads.each do |ad|
      if (ad.campaign)
        ad_ar = {:campaign => ad.campaign , :ad => ad}
        result << ad_ar
      end
    end
    render :json => { :ads => result }
  end

  private

  def ad_params
    # same as using "params[:ad]", except that it:
    # - raises an error if :ad is not present
    # - allows listed attributes to be mass-assigned
    params.require(:ad).permit(:campaign_id, :country, :price, :link_url)
  end

  def sort_column
    Ad.column_names.include?(params[:sort]) ? params[:sort] : "price"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
