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

    var form = $(".modal-form")
    var attrs = form.serializeJSON();
    GoodInvests.session.login(attrs, _, function (response) {
      this.message(response.responseText);
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

  message: function(message) {
    var elem = $('<message class="flash"> </message>')
    elem.append(message)
    this.$el.find("#holder").append(elem);
    var that = this;
    setTimeout( function(){that.$el.find(".flash").hide("blind", 500)}, 3000);
  },

  tagName: "div"
})
