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