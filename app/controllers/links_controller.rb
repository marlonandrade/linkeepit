class LinksController < ApplicationController

  before_action :set_link, only: [:update, :destroy]

  respond_to :html

  def index
    @links = current_user.links
    @new_link = Link.new
    respond_with(@links)
  end

  def create
    @link = Link.new(link_params)
    @link.user = current_user
    @link.save
    respond_with(@link)
  end

  def update
    @link.update(link_params)
    respond_with(@link)
  end

  def destroy
    @link.destroy
    respond_with(@link)
  end

  private
  def set_link
    @link = current_user.links.find params[:id]
  end

  def link_params
    params.require(:link).permit(:url)
  end
end
