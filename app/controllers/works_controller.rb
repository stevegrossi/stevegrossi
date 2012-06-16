class WorksController < ApplicationController
  
  before_filter :logged_in?, :except => [:index, :show]
  
  include ApplicationHelper
  
  # GET /works
  # GET /works.xml
  def index
    @works = Work.published.order('created_at DESC')
    @title = 'The finest websites, built with love'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @works }
    end
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
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work }
    end
  end
  
  def everything
    @title = 'Everything I\'ve read.'
    @works = Work.all
  end

  # GET /works/new
  # GET /works/new.xml
  def new
    @work = Work.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/1/edit
  def edit
    @work = Work.find(params[:id])
  end

  # POST /works
  # POST /works.xml
  def create
    @work = Work.new(params[:work])

    respond_to do |format|
      if @work.save
        format.html do
          flash[:success] = 'Yay, you made another website!'
          redirect_to @work
        end
        format.xml  { render :xml => @work, :status => :created, :location => @work }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /works/1
  # PUT /works/1.xml
  def update
    @work = Work.find(params[:id])

    respond_to do |format|
      if @work.update_attributes(params[:work])
        format.html do
          flash[:success] = 'Work sucessfully updated.'
          redirect_to works_path
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.xml
  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to(works_url) }
      format.xml  { head :ok }
    end
  end
end
