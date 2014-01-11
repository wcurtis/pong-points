class Api::GamesController < ApplicationController

  protect_from_forgery with: :null_session
  respond_to :json

  def index
    # @games = [
    #   { id: 1, player1: 1, player2: 2, status: "in_progress", created_at: "Fri, 10 Jan 2014 06:01:19 GMT" },
    # ]
    
    respond_with games: Game.all

    # respond_to do |format|
    #   format.json { render :json => @games }
    # end
  end

  def show
    # @game = { 
    #   game: { 
    #     id: 1, 
    #     player1: { id: 1, name: 'Wayne Rooney', profile_image_url: "/assets/players/rooney.jpg" }, 
    #     player2: { id: 2, name: 'Leo Messi' , profile_image_url: "/assets/players/messi.jpg" }, 
    #     status: "in_progress", 
    #     created_at: "Fri, 10 Jan 2014 06:01:19 GMT" 
    #   }
    # }
    
    game = Game.find(params[:id])

    response = game.as_json
    response['players'] = game.players.pluck(:id)

    respond_to do |format|
      format.json { render :json => { game: response } }
    end
  end

  def create
    @game = Game.new({
      status: 'in_progress'
    })

    params['players'].each do |playerId|
      @game.players.push(Player.find(playerId))
    end

    @game.save!
    render :json => @game
  end

  def game_params
    params.permit(:players)
  end

end
