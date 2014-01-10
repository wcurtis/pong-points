App.GameController = Ember.ObjectController.extend({

  gameInProgress: function() {
    return this.get('status') === 'in_progress';
  }.property('status'),

  actions: {
    finish: function() {
      this.set('winner', this.get('player1'));
      this.set('status', 'complete');
    }
  }

});