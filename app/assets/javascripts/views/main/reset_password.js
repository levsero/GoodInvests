GoodInvests.Views.ResetPassword = Backbone.View.extend ({
  template:JST["main_content/reset_form"],

  initialize: function (options) {
    this.id = options.id
    this.token = options.token
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
    console.log(password["password"])
    $.ajax({
      url: "/api/password_reset",
      type: "get",
      data: {token: this.token, id: this.id, password: password["password"]},
      success: function (data) {
        this.message("Password successfully reset.")
      }.bind(this),
      error: function (data) {
        this.message(data)
      }
    });
  },

  message: function(message) {
    var elem = $('<message class="flash"> </message>')
    elem.html(message)
    this.$el.find("#holder").append(elem);
    var that = this;
    setTimeout( function(){that.$el.find(".flash").hide("blind", 500)}, 3000);
  },

  tagName: "form"
})
