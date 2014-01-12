App.GameController = Ember.ObjectController.extend({

  needs: 'gamesItem',

  selected: null,

  gameInProgress: function() {
    return this.get('status') === 'in_progress';
  }.property('status'),

  /**
   * TODO: Find out a better way to bind these controller to the properties
   * of player1 and player2. There must be a better 'ember way'
   */
  player1Controller: function() {
    var controller = App.GamesItemController.create();
    controller.set('model', this.get('player1'));
    return controller;
  }.property('player1'),

  player2Controller: function() {
    var controller = App.GamesItemController.create();
    controller.set('model', this.get('player2'));
    return controller;
  }.property('player2'),

  actions: {
    finish: function() {

      var game = this.get('model');
      game.set('winner', 1);
      game.set('status', 'complete');

      game.save();
    },

    /**
     * TODO: This action also exists in the games.new controller.
     * Research how to DRY this up, maybe ember mixins?
     */
    toggleSelected: function(controllerName) {

      var controller = this.get(controllerName);
      var selected = this.get('selected');

      // Select player if no one is selected yet
      if (selected === null) {
        controller.select();
        this.set('selected', controller);
        return;
      }

      // Do nothing if player already selected
      if (selected.get('id') === controller.get('id')) {
        return;
      }

      // Deselect previously selected player and set new one
      selected.deselect();
      controller.select();
      this.set('selected', controller);
    }
  },

});