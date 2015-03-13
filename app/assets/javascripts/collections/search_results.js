GoodInvests.Collections.SearchResults = Backbone.Collection.extend({
  url: "api/search",

  parse: function (payload) {
    return payload.results;
  },

  model: function (attrs) {
    var type = attrs._type;
    delete attrs._type;

    return new GoodInvests.Models[type](attrs)
  }
})
