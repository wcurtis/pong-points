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
    finish: function(router, event) {

      router = this.get('router');
      var game = this.currentModel;

      game.set('winner', this.controllerFor('game').get('selected').get('id'));
      game.set('status', 'complete');

      game.save().then(function() {
        router.transitionTo('gameResult', game.get('id'));
      });
    },
  }

});