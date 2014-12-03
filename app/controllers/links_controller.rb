class LinksController < ApplicationController

  before_action :set_link, only: [:update, :destroy]

  respond_to :html

  def index
    index_instance_variables
    respond_with @links
  end

  def create
    @link = LinkBuilder.new.build link_params
    @link.user = current_user
    if @link.save
      redirect_to links_path
    else
      index_instance_variables
      render :index
    end
  end

  def update
    @link.update link_params
    redirect_to links_path
  end

  def destroy
    @link.destroy
    respond_with @link
  end

  private
  def set_link
    @link = current_user.links.find params[:id]
  end

  def link_params
    params.require(:link).permit :url, :read
  end

  def index_instance_variables
    @links = current_user.links.includes(:tags)
    if params[:read].present?
      @links = if params[:read] =~ /true/
                 @links.read
               else
                 @links.unread
               end
    end

    @new_link = Link.new
  end
end
