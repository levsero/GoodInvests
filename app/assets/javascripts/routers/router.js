GoodInvests.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = $("#container");
    this.$sidebar = $(".sidebar");
    this.$main = $(".main");

    this.fetchCollection();

    var view = new GoodInvests.Views.Sidebar({
      users: this.users, companies: this.companies
    });

    this.$sidebar.html(view.render().$el)
  },

  fetchCollection: function () {
    this.users = new GoodInvests.Collections.Users()
    this.companies = new GoodInvests.Collections.Companies()
    this.users.fetch();
    this.companies.fetch();
  },

  routes: {
    "": "index",
    "users/:id": "userShow",
    "companies/:id": "companyShow",
    "profile": "profileShow",
    "login": "login"
  },

  login: function () {
    var view = new GoodInvests.Views.Login()
    this.$rootEl.find(".nav-list").append(view.render().$el)
  },

  index: function () {
  },

  userShow: function (id) {
    var user = this.users.getOrFetch(id)
    var view = new GoodInvests.Views.UserShow({model: user})
    this._swapViews(view)
  },

  companyShow: function (id) {
    var company = this.companies.getOrFetch(id)
    var view = new GoodInvests.Views.CompanyShow({model: company})
    this._swapViews(view)
  },

  profileShow: function () {

  },

  _swapViews: function (view) {
    if (this.current_view) {
      this.current_view.remove()
    }
    this.current_view = view;
    this.$main.html(view.render().$el)
  }
})
