App.Player = DS.Model.extend({
  first_name: DS.attr( 'string' ),
  last_name: DS.attr( 'string' ),
  profile_image_url: DS.attr( 'string' ),
  
  name: function() {
    return this.get('first_name') + ' ' + this.get('last_name');
  }.property('first_name', 'last_name'),
});

// App.Player.FIXTURES = [
//   { id: 1, name: 'Wayne Rooney', profile_image_url: "/assets/players/rooney.jpg" },
//   { id: 2, name: 'Leo Messi' , profile_image_url: "/assets/players/messi.jpg" }
// ];