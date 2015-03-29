GoodInvests.Views.Navbar = Backbone.CompositeView.extend ({
  template:JST["navbar/navbar"],

  initialize: function (options) {
    this.collection = GoodInvests.session.current_user.notifications();
    this.$el.addClass("header-list group");
    this.listenTo(GoodInvests.session, "loggedIn", this.render);
    this.listenTo(GoodInvests.session, "signedOut", this.render);
    this.listenTo(this.collection, "add remove change reset", this.render);
    this.listenTo(this.collection, "sync reset", this.badge);
  },

  render: function () {
    this.$el.html(this.template({user: GoodInvests.session}));
    this.isLoggedIn()
    return this;
  },

  badge: function () {
    this.$el.find(".badge").html(this.collection.length);
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

  notifications: function () {
    this.$(".header-notifications").empty();
    this.collection.each( function (notification) {
        var notificationView = new GoodInvests.Views.CollectionListItem({ model: notification })
        this.$(".header-notifications").append(notificationView.render().$el)
      }.bind(this)
    );

    if (this.collection.length > 0) {
      this.$(".header-notifications").prepend('<li class="read-all">mark all as read</li>')
    }
  },

  signOut: function () {
    var view = new GoodInvests.Views.SignedOut({ model: this.model })
    this.$el.find(".signs").html(view.render().$el)
    this.notifications();
  },

  tagName: "div",

  events: {
    "click .read-all": "readAll",
    "click .notification-li": "toggleNone"
  },

  toggleNone: function () {
    this.collection.fetch({
      success: function () {
        this.$el.find(".header-notifications").toggleClass("none");
      }.bind(this)}
    );
  },

  readAll: function (event) {
    event.preventDefault();
    $.ajax({
      url: "api/notifications/read",
      method: "get",
      success: function (data) {
        //remove all
        this.collection.reset()
      }.bind(this)
    })
  }
})
