GoodInvests.Views.LogInForm = Backbone.View.extend ({
  template:JST["navbar/log_in_form"],

  initialize: function () {
  },

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  events: {
    "click #login-button": "login",
    "click #login-guest": "guestLogin"
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
    GoodInvests.session.login(attrs, _, function (response) {
      this.$el.find("#errors").append(response.responseText);
      var errorHeight = $("#errors").height() + 30;
      $(".modal-form").height(166 + errorHeight)
    }.bind(this));
  },

  guestLogin: function (event){
    event.preventDefault();
    var form = $(event.currentTarget).parent().parent().parent();
    form.find("#form-email").val("testing@gmail.com");
    form.find("#form-password").val("password");
    form.find("#login-button").click();
  },

  register: function (event) {
    event.preventDefault();
  },

  tagName: "div"
})
