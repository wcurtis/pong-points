App.Game = DS.Model.extend({
  // winner: DS.belongsTo('player'),
  winner: DS.attr('number'),
  status: DS.attr('string', {
    defaultValue: 'in_progress'
  }),
  created_at: DS.attr('date', {
      defaultValue: function() { return new Date(); }
  }),
  st_points_change: DS.attr('number'),

  player1: function() {
    return this.get('players')[0];
  }.property('players'),

  player2: function() {
    return this.get('players')[1];
  }.property('players'),

  winningPlayer: function() {
    return this.get('players').findBy('id', this.get('winner'));
  }.property('winner'),

  losingPlayer: function() {
    if (this.get('player1').id != this.get('winner')) {
      return this.get('player1');
    }
    return this.get('player2');
  }.property('winner'),

  players: DS.attr('raw')
});

App.GameSerializer = DS.RESTSerializer.extend({

  // TODO: Remove root object
  // First, restructure the top-level so it's organized by type
  // extractSave: function(store, type, payload, id, requestType) {
  //   debugger;
  //   payload = payload.game;
  //   return this._super(store, type, payload, id, requestType);
  // },

  /**
   * Not doing anything here for now, may do later
   */
  serialize: function(game, options) {
    json = this._super(game, options);
    return json;
  },

  /**
   * Ember wraps posts with the root key by default so here
   * we remove it.
   */
  serializeIntoHash: function(hash, type, record, options) {
    Ember.merge(hash, this.serialize(record, options));
  }
});

// App.Game.FIXTURES = [
//   { id: 1, player1: 1, player2: 2, created_at: new Date() },
// ];