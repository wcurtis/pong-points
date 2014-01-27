Ember.Handlebars.helper('fromNow', function(value, options) {
  return moment(value).fromNow();
});