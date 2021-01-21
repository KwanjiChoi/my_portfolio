class PrefecturesController < ApplicationController
  def cities
    prefecture = Prefecture.find(params[:prefecture_id])
    @cities = prefecture.cities.select(:id, :name)
    render json: @cities
  end
end
