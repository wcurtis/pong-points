class Api::PlayersController < ApplicationController

  respond_to :json

  def index
    # Not sure why we need the as_json but if it's not therer each object is wrapped in 'players'
    respond_with players: Player.all
  end

  def show
    player = Player.find(params[:id])

    respond_to do |format|
      format.json { render :json => { player: player }}
    end
  end

end
