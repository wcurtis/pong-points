App.GamesNewController = Ember.ArrayController.extend({

  itemController: 'gamesItem',

  selected: [],

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
    },

    /**
     * Learned a ton from this blog on how to use controllers
     * to do item selection the Ember way, this article is gold :)
     * http://gaslight.co/blog/intermediate-ember-controller-concepts
     */
    toggleSelected: function(controller) {

      var id = controller.get('id');
      var selected = this.get('selected');

      // Deselect if currently selected
      if (selected.contains(id)) {
        controller.deselect();
        this.set('selected', selected.without(id));
        return;
      }

      // Limit selection to 2 players
      if (selected.length < 2) {
        selected.push(id);
        controller.select();
      }
    }
  }

});
