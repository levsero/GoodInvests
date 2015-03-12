GoodInvests.Views.SignOut = Backbone.View.extend ({
  template:JST["log_out_button"],

  render: function () {
    this.$el.html("Sign Out");

    return this;
  },

  initialize: function () {
    this.$el.addClass("sign-out")
  },

  events: {
    "click": "signOut",
  },

  signOut: function (event) {
    console.log("sign out")
    event.preventDefault()
    $.ajax({
      url: "/api/session",
      type: "delete",
      success: function (data) {
        Backbone.history.navigate("", {trigger: true})
      }.bind(this)
    });
  },

  tagName: "button"
})
