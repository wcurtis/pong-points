class Api::GamesController < ApplicationController

  protect_from_forgery with: :null_session
  respond_to :json

  def index
    # @games = [
    #   { id: 1, player1: 1, player2: 2, status: "in_progress", created_at: "Fri, 10 Jan 2014 06:01:19 GMT" },
    # ]
    
    result = Game.all.where("status = 'finished'").order("created_at DESC").take(5).map { |game| 
      result = game.as_json
      result['players'] = game.players
      result
    }

    respond_with games: result

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

    renderObject game
  end

  def create
    @game = Game.new({
      status: 'in_progress'
    })

    params['players'].each do |playerId|
      @game.players.push(Player.find(playerId))
    end

    @game.save!
    renderObject @game
  end

  def update

    @game = Game.find(params[:id])

    if (params[:winner])
      @game.winner = params[:winner]
      @game.status = 'finished'
      @game.save!
    end
    renderObject @game
  end

  def cancel
    @game = Game.find(params[:id])
    @game.cancel
    renderObject @game
  end

  # Serializes and renders our game
  # TODO: Need to get active model serializers working
  def renderObject game
    response = game.as_json
    response['players'] = game.players

    respond_to do |format|
      format.json { render :json => { game: response } }
    end
  end

  def game_params
    params.permit(:players, :winner)
  end

end
