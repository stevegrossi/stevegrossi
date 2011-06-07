class WritingsController < ApplicationController
  
  before_filter :logged_in?, :except => [:index, :show]
  
  # GET /writings
  # GET /writings.xml
  def index
    @body_class = 'writings'
    @writings = Writing.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @writings }
    end
  end

  # GET /writings/1
  # GET /writings/1.xml
  def show
    @body_class = 'writing'
    @writing = Writing.find(params[:id])

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
        format.html { redirect_to(@writing, :notice => 'Writing was successfully created.') }
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
        format.html { redirect_to(@writing, :notice => 'Writing was successfully updated.') }
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
