// http://emberjs.com/guides/models/using-the-store/

// App.Store = DS.Store.extend({
//   // Override the default adapter with the `DS.ActiveModelAdapter` which
//   // is built to work nicely with the ActiveModel::Serializers gem.
//   adapter: '_ams'
// });

DS.RESTAdapter.reopen({
  namespace: 'api',
});

App.Store = DS.Store.extend({
  revision: 13,
  adapter: DS.RESTAdapter
});

/**
 * This lets us specify DS.attr('raw') in our models
 * so we can access array and object properties sent
 * back from our api.
 */
App.RawTransform = DS.Transform.extend({
  serialize: function(value) {
    return value;
  },
  deserialize: function(value) {
    return value;
  }
});