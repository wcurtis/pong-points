App.GamesNewRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('player');
  }
});