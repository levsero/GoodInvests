GoodInvests.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = $("container");
    this.$sidebar = $(".sidebar");
    this.$main = $(".main");

    this.users = new GoodInvests.Collections.Users()
    this.companies = new GoodInvests.Collections.Companies()
    this.users.fetch();
    this.companies.fetch();

    var view = new GoodInvests.Views.Sidebar({
      users: this.users, companies: this.companies
    });

    this.$sidebar.html(view.render().$el)
  },

  routes: {
    "": "index",
    "users/:id": "userShow"
  },

  index: function () {

  },

  userShow: function (id) {
    var user = this.Users.getOrFetch(id)
    var content = GoodInvests.Views.ShowUser.render({model: user})
  },

  _swapViews: function (view) {
    if (this.current_view) {
      this.current_view.remove()
    }
    this.current_view = view;
    this.$main.html(view.render().$el)
  }
})
