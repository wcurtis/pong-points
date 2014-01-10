App.Game = DS.Model.extend({
  player1: DS.belongsTo('player'),
  player2: DS.belongsTo('player'),
  winner: DS.belongsTo('player'),
  status: DS.attr('string', {
    defaultValue: 'in_progress'
  }),
  created_at: DS.attr('string', {
      defaultValue: function() { return new Date(); }
  })
});

// App.Game.FIXTURES = [
//   { id: 1, player1: 1, player2: 2, created_at: new Date() },
// ];