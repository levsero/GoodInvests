GoodInvests.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = $("#container");
    this.$sidebar = $(".sidebar");
    this.$main = $(".main");
    this.$navbar = $(".navbar")

    this.fetchCollection();

    this.session = GoodInvests.session;

    // load sidebar
    var view = new GoodInvests.Views.Sidebar({
      users: this.users, companies: this.companies
    });
    this.$sidebar.html(view.render().$el)

    // load navbar
    this.nav = new GoodInvests.Views.Navbar({
      model: this.session
    });
    this.$navbar.html(this.nav.render().$el)
  },

  fetchCollection: function () {
    this.users = new GoodInvests.Collections.Users()
    this.companies = new GoodInvests.Collections.Companies()
    this.users.fetch();
    this.companies.fetch();
  },

  routes: {
    "": "index",
    "users/profile": "profileShow",
    "users/:id": "userShow",
    "companies/:id": "companyShow",
    "lists": "listsShow"
  },

  index: function () {
  },

  listsShow: function () {

  },

  userShow: function (id) {
    var user = this.users.getOrFetch(id);
    var view = new GoodInvests.Views.UserShow({model: user, session: this.session});
    this._swapViews(view);
  },

  companyShow: function (id) {
    var company = this.companies.getOrFetch(id);
    var view = new GoodInvests.Views.CompanyShow({model: company, session: this.session});
    this._swapViews(view);
  },

  profileShow: function () {

  },

  _swapViews: function (view) {
    if (this.current_view) {
      this.current_view.remove();
    }
    this.current_view = view;
    this.$main.html(view.render().$el);
  }

})
