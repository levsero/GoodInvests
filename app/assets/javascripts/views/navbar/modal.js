GoodInvests.Views.Modal = Backbone.View.extend ({
  template:JST["navbar/modal"],
  initialize: function () {
    this.$el.addClass("transition")
  },

  render: function () {
    this.$el.html(this.template());
    this.view = new GoodInvests.Views.LogInForm();
    this.$el.find("form").append(this.view.render().$el);

    return this;
  },

  events: {
    "click #register": "register",
    "click #log-in": "logIn",
    "click .js-modal-open": "toggleModal",
    "click .js-modal-close": "toggleModal"
  },

  toggleModal: function (event) {
    event.preventDefault();
    $(".modal").toggleClass("is-open");
    var height = $(".modal-form").height();
    $(".modal-form").height(height);
  },

  logIn: function (event) {
    event.preventDefault();
    this.view.remove();
    $(".modal-form").height(166);
    this.view = new GoodInvests.Views.LogInForm();
    this.$el.find("form").append(this.view.render().$el);
  },

  register: function (event) {
    event.preventDefault();
    this.view.remove();
    $(".modal-form").height(336);
    this.view = new GoodInvests.Views.RegisterForm();
    this.$el.find("form").append(this.view.render().$el);
  },

  tagName: "div"
})
