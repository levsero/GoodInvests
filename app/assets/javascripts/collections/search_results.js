GoodInvests.Collections.SearchResults = Backbone.Collection.extend({
  url: "api/search",

  parse: function (payload) {
    this.pageInfo = payload.page;
    delete payload.page;
    
    return payload.results;
  },

  model: function (attrs) {
    var type = attrs._type;
    delete attrs._type;

    return new GoodInvests.Models[type](attrs)
  }
})
