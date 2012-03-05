class AssetPlatformsController < ApplicationController
  unloadable

  def new
    @asset_platform = AssetPlatform.new(params[:asset_platform])
    if request.post? && @asset_platform.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
    end
  end

  def edit
    @asset_platform = AssetPlatform.find(params[:id])
    if request.post? && @asset_platform.update_attributes(params[:asset_platform])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
    end
  end

  def destroy
    asset_platform = AssetPlatform.find(params[:id])
    asset_platform.destroy
    redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
  end
end
