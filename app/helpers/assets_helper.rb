module AssetsHelper
  def has_right(the_asset)
    User.current.admin? or the_asset.user_id == User.current.id
  end
end
