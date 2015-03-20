GoodInvests.Views.PasswordReset = Backbone.View.extend ({
  template:JST["navbar/reset_form"],

  initialize: function () {
  },

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  events: {
    "click #reset-button": "login"
  },

  toggleModal: function (event) {
    event.preventDefault();
    $(".modal").toggleClass("is-open");
  },

  login: function (event) {
    event.preventDefault();
    this.$el.find("#errors").empty();

    // TODO refactor to remove parents
    var form = $(event.currentTarget).parent().parent().parent()
    var attrs = form.serializeJSON();
    $.ajax({
      url: "api/password_reset_request",
      data: {email: attrs["email"]},
      method: "get",
      success: function () {
        this.message("A password reset link will be emailed to you shortly.")
      }.bind(this),
      error: function () {
        this.message("Please ensure you are entering correct email address.")
      }.bind(this)
    })
  },

  message: function(message) {
    var elem = $('<message class="flash"> </message>')
    elem.html(message)

    this.$el.find("#holder").append(elem);

    var that = this;
    setTimeout( function(){that.$el.find(".flash").hide("blind", 500)}, 3000);
  },

  register: function (event) {
    event.preventDefault();
  },

  tagName: "div"
})
