GoodInvests.Collections.Users = Backbone.Collection.extend ({
  url: "api/users",

  model: GoodInvests.Models.User,

  getOrFetch: function (id) {
    var user = this.get(id);
    if (!user) {
      user = new GoodInvests.Models.User({"id": id});
    }
    user.fetch()

    return user;
  },

  parse: function (payload) {
    this.pageInfo = payload.page;
    delete payload.page;
    return payload["users"];
  },
})
