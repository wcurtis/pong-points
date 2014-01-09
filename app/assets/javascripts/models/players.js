App.Player = DS.Model.extend({
  name: DS.attr( 'string' ),
  profile_image_url: DS.attr( 'string' )
});

App.Player.FIXTURES = [
  { id: 1, name: 'Wayne Rooney', profile_image_url: "/assets/players/rooney.jpg" },
  { id: 2, name: 'Leo Messi' , profile_image_url: "/assets/players/messi.jpg" }
];