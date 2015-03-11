GoodInvests.Views.Login = Backbone.View.extend ({
  template:JST["log_in_form"],

  render: function () {
    this.$el.html(this.template({}));

    return this;
  },

  initialize: function () {
    this.$el.addClass("login")
  },

  events: {
    "submit": "login"
  },

  tagName: "form"
})
