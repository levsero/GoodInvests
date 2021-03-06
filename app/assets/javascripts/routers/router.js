GoodInvests.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = $("#container");
    this.$sidebar = $(".sidebar");
    this.$main = $(".main");
    this.$navbar = $(".navbar")

    this.fetchCollections();

    this.session = GoodInvests.session;

    // load sidebar
    var view = new GoodInvests.Views.Sidebar({
      users: this.users, companies: this.companies
    });
    this.$sidebar.html(view.render().$el)

    // load navbar
    this.nav = new GoodInvests.Views.Navbar();
    this.$navbar.html(this.nav.render().$el)
  },

  fetchCollections: function () {
    this.users = new GoodInvests.Collections.Users()
    // fill the user lists while loading
    for (var i=0; i < 15; i++) {
      this.users.add(new GoodInvests.Models.User({}));
    }
    this.users.pageInfo = { current: 0, num_pages: 0, num_items: 0}

    this.companies = new GoodInvests.Collections.Companies()
    this.users.fetch({
      data: {
				page: 1
			}
    });
    this.companies.fetch({
      data: {
				page: 1
			}
    });
  },

  routes: {
    "": "index",
    "users/:id": "userShow",
    "companies/:id": "companyShow",
    "password_reset/:token/:id": "passwordReset"
  },

  index: function () {
    var view = new GoodInvests.Views.Index({});
    this._swapViews(view);
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

  passwordReset: function (token, id) {
    var view = new GoodInvests.Views.ResetPassword( {token: token, id: id})
    this._swapViews(view)
  },

  _swapViews: function (view) {
    if (this.current_view) {
      this.current_view.remove();
    }
    this.current_view = view;
    this.$main.html(view.render().$el);
  }

})
