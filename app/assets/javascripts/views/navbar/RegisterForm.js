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
    var that = this;

    // TODO refactor to remove parents
    var form = $(event.currentTarget).parent().parent()
    var attrs = form.serializeJSON();
    var user = new GoodInvests.Models.User();

    user.save(attrs.user, {
      success: function () {
        GoodInvests.session.login(attrs, GoodInvests.session.newUser.bind(GoodInvests.session) );
      }.bind(this),

      error: function (model, response, options) {
        _.each(response.responseJSON, function(error) {
          that.$el.find("#errors").append(error + "<br>" );
          var errorHeight = $("#errors").height() + 20;
          $(".modal-form").height(366 + errorHeight);
        })
      }
    })
  },

  tagName: "div"
})
