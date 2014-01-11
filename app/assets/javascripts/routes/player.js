App.PlayerRoute = Ember.Route.extend({

  model: function(params) {
    return this.store.find('player', params.id);
  }
});