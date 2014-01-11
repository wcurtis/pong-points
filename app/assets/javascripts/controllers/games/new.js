App.GamesNewController = Ember.ArrayController.extend({

  actions: {
    save: function() {

      var self = this;

      var gameData = {
        // TODO: Get these ids from user selection
        players: [1,2]
      };

      var game = this.store.createRecord('game', gameData);
      
      game.save().then(function() {
        self.transitionToRoute('game', game);
      });
    }
  }

});