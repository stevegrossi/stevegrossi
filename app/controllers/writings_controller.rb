class WritingsController < ApplicationController

  before_filter :logged_in?, :except => [:index, :show]

  # GET /writings
  # GET /writings.xml
  def index
    @title = 'I write things'
    @description = 'Some thoughts I\'ve liked enough to write down'
    @writings = Writing.published

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @writings }
    end
  end
  
  def everything
    @title = 'All Writings'
    @writings = Writing.all
  end

  # GET /writings/1
  # GET /writings/1.xml
  def show
    @writing = Writing.find(params[:id])
    @title = @writing.title
    @description = @writing.summary unless @writing.summary.blank?
    
    if @writing.draft?
      if current_user || params[:draft] == 'yep'
        flash.now[:alert] = 'This is a draft.'
      else
        flash[:error] = 'You must be logged in to view this draft.'
        redirect_to writings_path and return
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @writing }
    end
  end

  # GET /writings/new
  # GET /writings/new.xml
  def new
    @writing = Writing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @writing }
    end
  end

  # GET /writings/1/edit
  def edit
    @writing = Writing.find(params[:id])
  end

  # POST /writings
  # POST /writings.xml
  def create
    @writing = Writing.new(params[:writing])

    respond_to do |format|
      if @writing.save
        format.html do
          flash[:success] = 'Yay, you wrote another thing!'
          redirect_to @writing
        end
        format.xml  { render :xml => @writing, :status => :created, :location => @writing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @writing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /writings/1
  # PUT /writings/1.xml
  def update
    @writing = Writing.find(params[:id])

    respond_to do |format|
      if @writing.update_attributes(params[:writing])
        format.html do
          flash[:success] = 'Writing updated.'
          redirect_to @writing
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @writing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /writings/1
  # DELETE /writings/1.xml
  def destroy
    @writing = Writing.find(params[:id])
    @writing.destroy

    respond_to do |format|
      format.html { redirect_to(writings_url) }
      format.xml  { head :ok }
    end
  end
end
