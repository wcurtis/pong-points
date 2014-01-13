App.ApplicationRoute = Ember.Route.extend({

  actions: {
    loading: function() {

      Ember.$('.loader').show();

      this.router.one('didTransition', function() {
        Ember.$('.loader').hide();
      });
    }
  }
});