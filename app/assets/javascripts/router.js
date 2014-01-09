// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  // this.resource('posts');
  this.resource('home');
});

App.Router.reopen({
  rootURL: '/home/'
});