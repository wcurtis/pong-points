App.GameResultRoute = Ember.Route.extend({

  templateName: 'game/result',

  model: function(params) {
    return this.store.find('game', params.id);
  },
});