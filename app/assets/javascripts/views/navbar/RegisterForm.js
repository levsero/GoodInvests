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
    var form = $(event.currentTarget).parent().parent().parent()
    var attrs = form.serializeJSON();
    var user = new GoodInvests.Models.User();
    user.save(attrs.user, {
      success: function () {
        GoodInvests.session.login(attrs, GoodInvests.session.newUser.bind(GoodInvests.session) );
      }.bind(this),

      error: function (model, response, options) {
        var elem = $('<content>')
        _.each(response.responseJSON, function(error) {
          elem.append("<p>" + error + "</p>" );
        })
        that.message(elem.html())
      }
    })
  },

  message: function(message) {
    var elem = $('<message class="flash"> </message>')
    elem.append(message)
    console.log(elem)
    this.$el.find("#holder").append(elem);
    var that = this;
    setTimeout( function(){that.$el.find(".flash").hide("blind", 500)}, 3000);
  },

  tagName: "div"
})
