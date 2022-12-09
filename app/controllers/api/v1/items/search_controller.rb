class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:min_price] && params[:max_price]
      render json: ItemSerializer.new(Item.find_range(params[:min_price], params[:max_price]))
    elsif params[:min_price]
      render json: ItemSerializer.new(Item.find_min(params[:min_price]))
    elsif params[:max_price]
      render json: ItemSerializer.new(Item.find_max(params[:max_price]))
    else params[:name]
      render json: ItemSerializer.new(Item.search_item(params[:name]))
    end
  end
end
