class SiteNoticesController < ApplicationController

  skip_before_action :authenticate_user!
  skip_before_action :authorize

  def show
    @contact = SiteNoticeQueries.contact
  end
end