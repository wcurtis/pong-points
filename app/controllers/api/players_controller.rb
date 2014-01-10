class Api::PlayersController < ApplicationController

  def index
    @players = [
      { id: 1, name: 'Wayne Rooney', profile_image_url: "/assets/players/rooney.jpg" },
      { id: 2, name: 'Leo Messi' , profile_image_url: "/assets/players/messi.jpg" }
    ]
    
    respond_to do |format|
      format.json { render :json => @players }
    end
  end

end
