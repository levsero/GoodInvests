GoodInvests.Views.Login = Backbone.View.extend ({
  template:JST["log_in_form"],

  render: function () {
    this.$el.html(this.template({}));

    return this;
  },

  initialize: function () {
    this.$el.addClass("modal")
  },

  events: {
    "submit form": "login",
  },

  login: function (event) {
    event.preventDefault()
    var attrs = $(event.currentTarget).serializeJSON()

    $.ajax({
      url: "/api/session",
      type: "post",
      data: attrs,
      success: function (data) {
        Backbone.history.navigate("", {trigger: true})
      }.bind(this)
    });
  },

  tagName: "div"
})
