App.GameRoute = Ember.Route.extend({

  model: function(params) {
    return this.store.find('game', params.id);
  },

  /**
   * Redirect to the game result page if the game is finished
   */
  afterModel: function(model, transition) {
    if (model.get('status') === 'finished') {
      this.transitionTo('gameResult', model);
    }
  },

  // Clear any previously selected players
  activate: function() {
    this.controllerFor('game').reset();
  },

  actions: {
    finish: function() {

      var self = this;

      router = this.get('router');
      var game = this.currentModel;

      game.set('winner', this.controllerFor('game').get('selected').get('id'));
      game.set('status', 'complete');

      game.save().then(function() {
        // We remove this game from the store so it's forced to refetch
        // it on the route transition. This is required so the request
        // will wait for the activity to finish processing
        self.store.unloadRecord(game);
        router.transitionTo('gameResult', game.get('id'));
      });
    },
  }

});