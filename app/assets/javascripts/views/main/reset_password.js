GoodInvests.Views.ResetPassword = Backbone.View.extend ({
  template:JST["main_content/reset_form"],

  initialize: function (options) {
    this.id = options.id
    this.token = options.token
    this.$el.addClass("reset")
  },

  render: function () {
    this.$el.html(this.template());
    return this
  },

  events: {
    "submit": "submitReset"
  },

  submitReset: function (event) {
    event.preventDefault();
    var password = $(event.currentTarget).serializeJSON();
    $.ajax({
      url: "/api/password_reset",
      type: "get",
      data: {token: this.token, id: this.id, password: password["password"]},
      success: function (data) {
        this.message("Password successfully reset.")
      }.bind(this),
      error: function (data) {
        this.message("Error while reseting password, please try again")
      }.bind(this)
    });
  },

  tagName: "form"
});

_.extend(GoodInvests.Views.ResetPassword.prototype, GoodInvests.Views.HelperMethods)
