class ResourcesController < ApplicationController
include ResourceHelper

  def index
    @stone = Stone.find(params[:stone_id])
    @resource = Resource.new
    render :json => render_to_string('index', layout: false).to_json
  end

  def new
    @stone = Stone.find(params[:stone_id])
    @resource = Resource.new
    render :json => render_to_string(partial: 'form', locals: {resource: @resource, stone: @stone }).to_json
  end

  def create
    info = params[:resource]
    info_with_photos = info.merge(:photo => top_image_url(info["title"]))
    resource = Resource.create(info_with_photos)
    resources_stone = ResourcesStone.create(resource_id: resource.id, stone_id: params[:stone_id])
    render :json => render_to_string(partial: 'resources/resources_stone', locals: { resources_stone: resources_stone}).to_json
  end
end
