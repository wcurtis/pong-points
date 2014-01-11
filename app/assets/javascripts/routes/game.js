App.GameRoute = Ember.Route.extend({

  model: function(params) {
    var self = this;

    /**
     * Here we are loading the winner model from the id after
     * the game is fetched. The belongsTo relation in ember data
     * does this but that means we can't POST an id in the winner 
     * field because the model expects an object. Doing this for
     * now, could probably just use belongsTo and set the winner model
     * on the game object and save, but wanted to try some manual stuff
     * out to learn.
     */
    return this.store.find('game', params.id).then(function(game) {
      return self.store.find('player', game.get('winner')).then(function(winner) {
        game.set('winnerModel', winner);
        return game;
      });
    });
  },

  // setupController: function(controller, model) {
  //   debugger;
  // }
});