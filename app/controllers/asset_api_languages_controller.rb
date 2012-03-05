class AssetApiLanguagesController < ApplicationController
  unloadable

  def new
    @api_language = AssetApiLanguage.new(params[:asset_api_language])
    if request.post? && @api_language.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
    end
  end

  def edit
    @api_language = AssetApiLanguage.find(params[:id])
    if request.post? && @api_language.update_attributes(params[:asset_api_language])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
    end
  end

  def destroy
    api_language = AssetApiLanguage.find(params[:id])
    api_language.destroy
    redirect_to :controller => "settings", :action => "plugin", :id => "redmine_assets"
  end


end
