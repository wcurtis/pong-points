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

});