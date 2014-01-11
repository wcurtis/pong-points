App.Game = DS.Model.extend({
  winner: DS.belongsTo('player'),
  status: DS.attr('string', {
    defaultValue: 'in_progress'
  }),
  created_at: DS.attr('string', {
      defaultValue: function() { return new Date(); }
  }),

  player1: function() {
    return this.get('players')[0];
  }.property('players'),

  player2: function() {
    return this.get('players')[1];
  }.property('players'),

  players: DS.attr('raw')
});

// App.Game.FIXTURES = [
//   { id: 1, player1: 1, player2: 2, created_at: new Date() },
// ];