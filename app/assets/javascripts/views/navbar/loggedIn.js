GoodInvests.Views.LoggedIn = Backbone.View.extend ({
  template:JST["navbar/logged_in"],

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  initialize: function () {
  },

  events: {
    "submit form": "login",
    "click #register-button": "register",
    "click .js-modal-open": "toggleModal",
    "click .js-modal-close": "toggleModal"
  },

  toggleModal: function (event) {
    event.preventDefault();
    $(".modal").toggleClass("is-open");
  },

  login: function (event) {
    event.preventDefault();

    var attrs = $(event.currentTarget).serializeJSON();

    this.model.login(attrs);
  },

  register: function (event) {
    event.preventDefault();
  },

  tagName: "div"
})
