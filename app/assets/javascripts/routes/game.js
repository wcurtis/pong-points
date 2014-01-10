App.GameRoute = Ember.Route.extend({

  model: function(params) {
    this.store.getById(params.id);
  }
});