class WritingsController < ApplicationController

  before_filter :logged_in?, except: [:index, :show]

  def index
    @title = 'I write things'
    @description = 'Some thoughts I\'ve liked enough to write down'
    @writings = Writing.published
  end

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
  end

  def new
    @writing = Writing.new
  end

  def edit
    @writing = Writing.find(params[:id])
  end

  def create
    @writing = Writing.new(params[:writing])
    if params[:commit] == 'Publish'
      @writing.published_at ||= Time.now
    end
    if @writing.save
      flash[:success] = 'Yay, you wrote another thing!'
      redirect_to @writing
    else
      render action: "new"
    end
  end

  def update
    @writing = Writing.find(params[:id])
    # Set '' to nil so ||= works 2 below
    params[:writing][:published_at] = nil if params[:writing][:published_at].blank?
    if params[:commit] == 'Publish'
      params[:writing][:published_at] ||= Time.now
    elsif params[:commit] == 'Unpublish'
      params[:writing][:published_at] = nil
    end
    if @writing.update_attributes(params[:writing])
      flash[:success] = 'Writing updated.'
      redirect_to @writing
    else
      render action: "edit"
    end
  end

  def destroy
    @writing = Writing.find(params[:id])
    flash[:success] = "You deleted <b>#{@writing.title}</b>."
    @writing.destroy
    return redirect_to meta_writings_path
  end
end
