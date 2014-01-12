App.GamesItemController = Ember.ObjectController.extend({

  isSelected: false,

  select: function() {
    this.set('isSelected', true);
  },

  deselect: function() {
    this.set('isSelected', false);
  }

});
