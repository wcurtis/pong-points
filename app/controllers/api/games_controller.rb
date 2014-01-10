class Api::GamesController < ApplicationController

  def index
    @games = [
      { id: 1, player1: 1, player2: 2, status: "in_progress", created_at: "Fri, 10 Jan 2014 06:01:19 GMT" },
    ]
    
    respond_to do |format|
      format.json { render :json => @games }
    end
  end

  def show
    @game = { game: { id: 1, player1: 1, player2: 2, status: "in_progress", created_at: "Fri, 10 Jan 2014 06:01:19 GMT" }}
    
    respond_to do |format|
      format.json { render :json => @game }
    end
  end

end
