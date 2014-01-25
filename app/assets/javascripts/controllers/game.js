App.GameController = Ember.ObjectController.extend({

  needs: 'gamesItem',

  selected: null,

  gameInProgress: function() {
    return this.get('status') === 'in_progress';
  }.property('status'),

  canFinish: function() {
    return this.get('selected') !== null;
  }.property('selected'),

  finishing: false,

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

  /**
   * This clears all selected players, called by route activate
   */
  reset: function() {
    if (this.get('selected')) {
      // I don't think this ever gets called because new
      // controllers get created each time for player1 and player2.
      // TODO: Find the ember way to bind these controllers with properties.
      this.get('selected').deselect();
    }
    this.set('selected', null);
    this.set('finishing', false);
  }

});