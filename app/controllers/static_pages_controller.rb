require 'flickr'
class StaticPagesController < ApplicationController
  def index
    flickr = Flickr.new Figaro.env.flickr_api_key, Figaro.env.flickr_shared_secret
    unless params[:user_id].nil? || params[:user_id]== ''
      begin 
        @photos = flickr.people.getPhotos(user_id: params[:user_id])
        @notice = "Displaying your photos on flickr."
      rescue Flickr::FailedResponse
        @photos = flickr.photos.getRecent
        @notice = "Displaying recent photos uploaded on flickr because you have either not uploaded any photos or your user iid doesnt exist."
      end
    else  
      flash.now[:alert] = "Enter valid user id"
      render :index
    end
  end
end
