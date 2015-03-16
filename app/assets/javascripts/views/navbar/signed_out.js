GoodInvests.Views.SignedOut = Backbone.View.extend ({

  initialize: function (options) {
    this.$el.addClass("sign-out");
    // this.name = options.name;
  },

  render: function () {
    this.$el.html("Sign Out");
    this.$el.addClass("sign-out")
    return this;
  },

  events: {
    "click": "signOut",
  },

  signOut: function (event) {
    GoodInvests.session.signOut()
  },

  tagName: "button"
})
