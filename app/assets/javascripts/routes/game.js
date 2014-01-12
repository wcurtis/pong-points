App.GameRoute = Ember.Route.extend({



  model: function(params) {
    return this.store.find('game', params.id);
  },

  // Clear any previously selected players
  activate: function() {
    this.controllerFor('game').reset();
  },

  // setupController: function(controller, model) {
  //   debugger;
  // }
});