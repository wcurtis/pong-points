App.GameResultController = Ember.ObjectController.extend({

  needs: 'gamesItem',

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

});