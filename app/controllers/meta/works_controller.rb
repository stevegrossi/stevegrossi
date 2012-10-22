class Meta::WorksController < Meta::DashboardController

  def index
    @title = 'Everything I\'ve built.'
    @works = Work.all
  end

end