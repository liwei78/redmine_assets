class AssetsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize
  
  def index
    @recommends = Asset.recommends(12)
    @updateds   = Asset.last_updated(48)
  end
  
  def all
    unless params[:category].nil?
      @assets  = Asset.paginate(
        :conditions => ["asset_category_id =?", params[:category]],
        :page       => params[:page],
        :per_page   => 50,
        :order      => "updated_at desc")
    end
    unless params[:platform].nil?
      platform = AssetPlatform.find(params[:platform])
      @assets  = platform.assets.paginate(
        :page       => params[:page],
        :per_page   => 50,
        :order      => "updated_at desc")
    end
    unless params[:api].nil?
      api = AssetApiLanguage.find(params[:api])
      @assets  = api.assets.paginate(
        :page       => params[:page],
        :per_page   => 50,
        :order      => "updated_at desc")
    end
    if params[:category].nil? and params[:platform].nil? and params[:api].nil?
      @assets  = Asset.paginate(
        :page       => params[:page],
        :per_page   => 50,
        :order      => "updated_at desc")
    end
  end

  def new
    @asset = Asset.new
    @asset.author = User.current.name
  end
  
  def create
    @asset = Asset.new(params[:asset])
    if User.current.admin?
      if @asset.user_id.blank?
        @asset.user_id = User.current.id
      end
    else
      @asset.user_id = User.current.id
    end
    if @asset.save
      @asset.kfc(params[:asset_platform], params[:asset_api_language])
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => 'show', :id => @asset.id, :project_id => @project
    else
      render :action => :new
    end
  end
  
  def edit
    @asset = Asset.find(params[:id])
    check_right(@asset)
  end
  
  def update
    @asset = Asset.find(params[:id])
    check_right(@asset)
    AssetCategory.update_counters @asset.asset_category_id, :assets_count => -1 unless params[:asset][:asset_category_id].blank?
    if @asset.update_attributes(params[:asset])
      @asset.kfc(params[:asset_platform], params[:asset_api_language])
      AssetCategory.update_counters params[:asset][:asset_category_id], :assets_count => 1 unless params[:asset][:asset_category_id].blank?
      flash[:notice] = l(:notice_successful_update)
      redirect_to :action => 'show', :id => @asset.id, :project_id => @project
    else
      render :action => :new
    end
  end

  def show
    @asset = Asset.find(params[:id])
    @comments = AssetComment.paginate(
      :conditions => ["asset_comments.asset_id = ?", @asset.id], 
      :joins      => :user, 
      :page       => params[:page],
      :per_page   => 50,
      :order      => "id asc")
  end
  
  def recommend
    asset = Asset.find(params[:id])
    check_right(asset)
    if asset
      if asset.top?
        asset.update_attribute(:top, false)
      else
        asset.update_attribute(:top, true)
      end
    end
    flash[:notice] = l(:notice_successful_update)
    redirect_to :action => 'show', :id => asset.id, :project_id => @project
  end
  
  def destroy
    asset = Asset.find(params[:id])
    check_right(asset)
    asset.destroy if asset
    flash[:notice] = l(:notice_successful_delete)
    redirect_to :action => 'index', :project_id => @project
  end
  
  def my
    @assets  = Asset.paginate(
      :conditions => ["user_id = ?", User.current.id],
      :select => "assets.*, asset_categories.name as category_name", 
      :joins => "left join asset_categories on asset_categories.id = assets.asset_category_id",
      :page       => params[:page],
      :per_page   => 50,
      :order      => "updated_at desc")
  end
  
  def postcomment
    asset = Asset.find(params[:id])
    AssetComment.create(:user_id => User.current.id, :asset_id => asset.id,  :comment => params[:comment], :attachment => params[:attachment]) unless params[:comment].blank?
    redirect_to :back
  end
  
  def delcomment
    asset = Asset.find(params[:id])
    comment = asset.asset_comments.find(params[:cid])
    if comment
      check_right(comment)
      comment.destroy
    end
    redirect_to :back
  end
  
  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def check_right(the_asset)
    if !User.current.admin? and the_asset.user_id != User.current.id
      msg = []
      if !User.current.admin?
        msg << l(:notice_not_admin)
      end
      if the_asset.user_id != User.current.id
        msg << l(:notice_not_onwer)
      end
      render_403(:message => msg.join(' '))
    end
  end
  
end
