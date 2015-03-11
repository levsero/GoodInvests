GoodInvests.Collections.Users = Backbone.Collection.extend ({
  url: "api/users",

  model: GoodInvests.Models.User,

  getOrFetch: function (id) {
    var user = this.get(id);
    if (!user) {
      user = new GoodInvests.Models.User({"id": id});
      user.fetch()
    }
    // user.fetch({
    //   success: function () {
    //     this.add(user, {merge: true})
    //   }.bind(this)
    // })
    return user;
  },

  parse: function (payload) {
    return payload["users"];
  }
})
