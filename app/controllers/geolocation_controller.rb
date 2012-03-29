class GeolocationController < ApplicationController
  def reverse_geocode
    best_match = Geocoder.search("#{params[:lat]}, #{params[:lng]}").first
    render :text => "#{best_match.city}, #{best_match.country}"
  end
end