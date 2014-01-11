App.GamesNewController = Ember.ArrayController.extend({

  actions: {
    save: function() {

      var self = this;

      var gameData = {
        players: [1,2]
      };
      var game = this.store.createRecord('game', gameData);
      game.save(function() {
        self.transitionToRoute('game', game);
      });
    }
  }

});