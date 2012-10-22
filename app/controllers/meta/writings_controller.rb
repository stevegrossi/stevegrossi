class Meta::WritingsController < Meta::DashboardController

  def index
    @title = 'All Writings'
    @writings = Writing.all
  end

end