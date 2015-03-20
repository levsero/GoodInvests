GoodInvests.Views.PasswordReset = Backbone.View.extend ({
  template:JST["navbar/reset_form"],

  initialize: function () {
  },

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  events: {
    "click #reset-button": "reset"
  },

  toggleModal: function (event) {
    event.preventDefault();
    $(".modal").toggleClass("is-open");
  },

  reset: function (event) {
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
        this.message("If the email address is valid a reset link will be emailed to you shortly.")
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
