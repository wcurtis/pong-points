App.GamesNewController = Ember.ArrayController.extend({

  actions: {
    save: function() {
      var gameData = {
        id: 1,
        player1: this.store.getById('player', 1),
        player2: this.store.getById('player', 2)
      };
      var game = this.store.createRecord('game', gameData);
      // this.store.commit();
      this.transitionToRoute('game', game);
    }
  }

});