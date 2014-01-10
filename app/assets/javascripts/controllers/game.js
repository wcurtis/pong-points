App.GameController = Ember.ObjectController.extend({

  actions: {
    finish: function() {
      this.set('winner', this.get('player1'));
      this.set('status', 'complete');
    }
  }

});