App.GamesNewRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('player');
  },

  // Clear any previously selected players
  activate: function() {
    this.controllerFor('games.new').reset();
  },
});