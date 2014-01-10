App.GameRoute = Ember.Route.extend({

  model: function(params) {
    this.store.find('game', params.id);
  }
});