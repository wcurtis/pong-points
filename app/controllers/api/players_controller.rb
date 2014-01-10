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

  def show
    @players = [
      { id: 1, name: 'Wayne Rooney', profile_image_url: "/assets/players/rooney.jpg" },
      { id: 2, name: 'Leo Messi' , profile_image_url: "/assets/players/messi.jpg" }
    ]

    player = @players[params[:id].to_f - 1]

    respond_to do |format|
      format.json { render :json => { player: player }}
    end
  end

end
