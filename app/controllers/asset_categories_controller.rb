class AssetCategoriesController < ApplicationController
  unloadable

  def new
    @asset_category = AssetCategory.new(params[:asset_category])
    if request.post? && @asset_category.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
    end
  end

  def edit
    @asset_category = AssetCategory.find(params[:id])
    if request.post? && @asset_category.update_attributes(params[:asset_category])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
    end
  end

  def destroy
    asset_category = AssetCategory.find(params[:id])
    asset_category.destroy
    redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
  end

end
