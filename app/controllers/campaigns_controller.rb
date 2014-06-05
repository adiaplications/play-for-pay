class CampaignsController < ApplicationController
  #self.inheritance_column = nil
  layout "admin"

  helper_method :sort_column, :sort_direction

  def index
    @campaigns = Campaign.order(sort_column + " " + sort_direction)
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def new
    @campaign = Campaign.new
  end

  def create
    # Instantiate a new object using form parameters
    @campaign = Campaign.new(campaign_params)
    # Save the object
    if @campaign.save
      # If save succeeds, redirect to the index action
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
  end

  def update
# Find an existing object using form parameters
    @campaign = Campaign.find(params[:id])
# Update the object
    if @campaign.update_attributes(campaign_params)
# If update succeeds, redirect to the index action
      flash[:notice] = "Campaign updated successfully."
      redirect_to(:action => 'show', :id => @campaign.id)
    else
# If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    campaign = Campaign.find(params[:id]).destroy
    flash[:notice] = "Campaign '#{campaign.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  def show_ads_by_country
    result = {}
    campaigns = Campaign.active
    campaigns.each do |campaign|
      #if(campaign.ads)
        @ads = campaign.ads.get_by_country(params[:user_country]).sorted
          @ads.each do |ad|
            result.merge!({:campaign => campaign , :ad => ad})
          end
            #result << { :Campaign => ad.campaign.name}
            #"Image" => ad.campaign.image_url,
            #"Package Name" => ad.campaign.package_name,
            #"Type" => ad.campaign.package_type,
            #"Min SDK" => ad.campaign.min_sdk,
            #"Price" => ad.price,
            #"Link Url" => ad.link_url }
      #end
    end
  render :json => {:ads => result}
  end


  private

  def campaign_params
    # same as using "params[:campaign]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:campaign).permit(:company, :os, :commision_type, :name, :image_url, :package_name, :package_type, :min_sdk, :active, :notifications, :emailing, :sms, :instructions)
  end

  def sort_column
    Campaign.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
