// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  this.resource('games', function() {
	this.route('new');
  });
  this.resource('game', { path: '/games/:id' });
});