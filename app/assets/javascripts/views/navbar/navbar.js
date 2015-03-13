GoodInvests.Views.Navbar = Backbone.CompositeView.extend ({
  template:JST["navbar/navbar"],

  render: function () {
    this.$el.html(this.template({user: this.model}));
    this.isLoggedIn()

    return this;
  },

  initialize: function (options) {
    this.$el.addClass("group");
    this.listenTo(this.model, "loggedIn", this.render);
    this.listenTo(this.model, "signedOut", this.render);
  },

  isLoggedIn: function () {
    var isLoggedIn = this.model.isLoggedIn;
    if (!isLoggedIn){
      this.login()
    } else {
      this.signOut()
    }
  },

  login: function () {
    var view = new GoodInvests.Views.LoggedIn({model: this.model})
    this.$el.find(".signs").html(view.render().$el)
    this.current_view = view;
    this.addSubview("#signs", view);
  },

  signOut: function () {
    // TODO add name to .name
    var view = new GoodInvests.Views.SignedOut({model: this.model})
    this.$el.find(".signs").html(view.render().$el)
  },

  tagName: "ul"
})
