class WorksController < ApplicationController
  
  before_filter :logged_in?, :except => [:index, :show]
  
  include ApplicationHelper

  def index
    @works = Work.published
    @title = 'The finest websites, built with love'
  end

  # GET /works/1
  # GET /works/1.xml
  def show
    @work = Work.find(params[:id])
    @title = @work.title
    @description = "I built #{nice_url(@work.url)} for #{@work.client}."
    
    if @work.draft?
      if current_user || params[:draft] == 'yep'
        flash.now[:alert] = 'This is a draft.'
      else
        flash[:error] = 'You must be logged in to view this draft.'
        redirect_to works_path and return
      end
    end
  end
  
  def everything
    @title = 'Everything I\'ve read.'
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find(params[:id])
  end

  def create
    @work = Work.new(params[:work])
    if params[:commit] == 'Publish'
      @work.published_at ||= Time.now
    end
    if @work.save
      flash[:success] = 'Yay, you built another thing!'
      redirect_to @work
    else
      render :action => "new"
    end
  end

  def update
    @work = Work.find(params[:id])
    # Set '' to nil so ||= works 2 below
    params[:work][:published_at] = nil if params[:work][:published_at].blank?
    if params[:commit] == 'Publish'
      params[:work][:published_at] ||= Time.now
    elsif params[:commit] == 'Unpublish'
      params[:work][:published_at] = nil
    end
    if @work.update_attributes(params[:work])
      flash[:success] = 'Work updated.'
      redirect_to @work
    else
      render :action => "edit"
    end
  end

  def destroy
    @work = Work.find(params[:id])
    flash[:success] = "You deleted <b>#{@work.title}</b>."
    @work.destroy
    return redirect_to everything_works_path
  end
end
