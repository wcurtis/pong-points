App.IndexController = Ember.ArrayController.extend({

  sortProperties: ['created_at'],
  sortAscending: false,

  // Filters games by finished status so we don't show
  // any in_progress or cancelled games on the dashboard
  completedGames: (function() {
    return this.get('content').filterProperty('status', 'finished');
  }).property('content.@each.status', 'content')

});
