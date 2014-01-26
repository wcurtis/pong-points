App.GamesNewController = Ember.ArrayController.extend({

  itemController: 'gamesItem',

  selected: [],

  saving: true,

  canSave: function() {
    return this.get('selected').length === 2;
  }.property('selected'),

  actions: {
    save: function() {

      var self = this;

      var gameData = {
        players: this.get('selected').map(function(s) {
          return s.get('id');
        })
      };

      var game = this.store.createRecord('game', gameData);
      
      this.set('saving', true);
      game.save().then(function() {
        self.set('saving', false);
        self.transitionToRoute('game', game);
      });
    },

    /**
     * Learned a ton from this blog on how to use controllers
     * to do item selection the Ember way, this article is gold :)
     * http://gaslight.co/blog/intermediate-ember-controller-concepts
     */
    toggleSelected: function(controller) {

      var selected = this.get('selected');

      // Deselect if currently selected
      if (selected.contains(controller)) {
        controller.deselect();
        this.set('selected', selected.without(controller));
        return;
      }

      // Deselect the earliest selected player to make room for new one
      if (selected.length === 2) {
        var outcast = selected.shift();
        outcast.deselect();
      }

      // Limit selection to 2 players
      if (selected.length < 2) {
        selected.push(controller);

        // Need to reset and call toArray (to clone) or
        // ember won't pickup the change which is needed
        // for recalculating the canSave property
        this.set('selected', selected.toArray());
        controller.select();
      }
    }
  },

  /**
   * This clears all selected players, called by route activate
   */
  reset: function() {
    this.get('selected').forEach(function(selected) {
      selected.deselect();
    });
    this.set('selected', []);
    this.set('saving', false);
  }

});
