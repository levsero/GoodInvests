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
    var errorHeight = $("#errors").height();
    $("#errors").empty();

    $(".modal").toggleClass("is-open");
    var height = $(".modal-form").height() - errorHeight;
    $(".modal-form").height(height);
  },

  logIn: function (event) {
    event.preventDefault();
    this.view.remove();

    this.view = new GoodInvests.Views.LogInForm();
    this.$el.find("form").append(this.view.render().$el);

    var errorHeight = $("#errors").height() + 20;
    $(".modal-form").height(166 + errorHeight);
  },

  register: function (event) {
    event.preventDefault();
    this.view.remove();

    var errorHeight = $("#errors").height();
    $(".modal-form").height(386 + errorHeight);

    this.view = new GoodInvests.Views.RegisterForm();
    this.$el.find("form").append(this.view.render().$el);
  },

  tagName: "div"
})
