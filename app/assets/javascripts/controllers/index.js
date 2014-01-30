App.IndexController = Ember.ArrayController.extend({

  sortProperties: ['created_at'],
  sortAscending: false,

  // Filters games by finished status so we don't show
  // any in_progress or cancelled games on the dashboard
  // More about ArrayProxies: http://stackoverflow.com/a/13397509/540194
  completedGames: (function() {

    var content = this.get("content") || [];
    return Ember.ArrayProxy.createWithMixins(Ember.SortableMixin, {
      content: content.toArray(),
      sortProperties: this.get('sortProperties'),
      sortAscending: this.get('sortAscending')
    });
  }).property('content.@each.status', 'content', 'sortProperties', 'sortAscending')

});
