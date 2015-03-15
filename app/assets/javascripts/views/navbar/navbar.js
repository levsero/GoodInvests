GoodInvests.Views.Navbar = Backbone.CompositeView.extend ({
  template:JST["navbar/navbar"],

  initialize: function (options) {
    this.$el.addClass("group");
    this.listenTo(GoodInvests.session, "loggedIn", this.render);
    this.listenTo(GoodInvests.session, "signedOut", this.render);
  },

  render: function () {
    this.$el.html(this.template({user: GoodInvests.session}));
    this.isLoggedIn()
    return this;
  },

  isLoggedIn: function () {
    var isLoggedIn = GoodInvests.session.isLoggedIn;
    if (!isLoggedIn){
      this.login()
    } else {
      this.signOut()
    }
  },

  login: function () {
    var view = new GoodInvests.Views.Modal({ model: this.model })
    this.$el.find(".signs").html(view.render().$el)
    this.current_view = view;
    this.addSubview("#signs", view);
  },

  signOut: function () {
    var view = new GoodInvests.Views.SignedOut({ model: this.model })
    this.$el.find(".signs").html(view.render().$el)
  },

  tagName: "ul"
})
