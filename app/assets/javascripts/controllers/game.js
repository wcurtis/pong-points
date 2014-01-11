App.GameController = Ember.ObjectController.extend({

  gameInProgress: function() {
    return this.get('status') === 'in_progress';
  }.property('status'),

  actions: {
    finish: function() {

      var game = this.get('model');
      game.set('winner', 1);
      game.set('status', 'complete');

      game.save();
    }
  }

});