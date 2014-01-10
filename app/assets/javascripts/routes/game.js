App.GameRoute = Ember.Route.extend({

  model: function(params) {
    // the server returns `{ slug: 'foo-post' }`
    // return jQuery.getJSON("/posts/" + params.post_slug);
    this.store.getById(params.id);
  },

  // serialize: function(model) {
    // this will make the URL `/posts/foo-post`
    // return { post_slug: model.get('slug') };
  // }
});