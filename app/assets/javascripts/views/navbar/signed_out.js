GoodInvests.Views.SignedOut = Backbone.View.extend ({
  template:JST["navbar/signed_out"],

  render: function () {
    this.$el.html("Sign Out");
    this.$el.addClass("sign-out")
    return this;
  },

  initialize: function (options) {
    this.$el.addClass("sign-out");
    // this.name = options.name;
  },

  events: {
    "click": "signOut",
  },

  signOut: function (event) {
    this.model.signOut()
  },

  tagName: "button"
})
