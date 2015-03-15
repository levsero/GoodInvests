GoodInvests.Views.RegisterForm = Backbone.View.extend ({
  template:JST["navbar/register_form"],

  initialize: function () {
  },

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  events: {
    "click #register-button": "register",
  },

  toggleModal: function (event) {
    event.preventDefault();
    $(".modal").toggleClass("is-open");
  },

  register: function (event) {
    event.preventDefault();
    // TODO refactor to remove parents
    var form = $(event.currentTarget).parent().parent()
    var attrs = form.serializeJSON();
    user = new GoodInvests.Models.User();

    user.save(attrs.user, {
      success: function () {
        GoodInvests.session.login(attrs)
      }.bind(this),

      failure: function (data) {
        console.log(data)
      }
    })
  },

  tagName: "div"
})
