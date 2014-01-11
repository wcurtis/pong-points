App.PlayerRoute = Ember.Route.extend({

  model: function(params) {
    // Something's may be wrong with ember data since this works but the next one dosn't
    return {
      first_name: "Bill"
    };
    this.store.find('player', params.id);
  }
});