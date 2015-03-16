GoodInvests.Views.LogInForm = Backbone.View.extend ({
  template:JST["navbar/log_in_form"],

  initialize: function () {
  },

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  events: {
    "click #login-button": "login"
  },

  toggleModal: function (event) {
    event.preventDefault();
    $(".modal").toggleClass("is-open");
  },

  login: function (event) {
    event.preventDefault();

    // TODO refactor to remove parents
    var form = $(event.currentTarget).parent().parent()
    var attrs = form.serializeJSON();
    GoodInvests.session.login(attrs, function (message) {
      this.$el.find("errors").append(message);
    }.bind(this));
  },

  register: function (event) {
    event.preventDefault();
  },

  tagName: "div"
})
