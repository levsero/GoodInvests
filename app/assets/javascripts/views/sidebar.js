GoodInvests.Views.Sidebar = Backbone.CompositeView.extend ({
  template:JST["sidebar/sidebar"],

  render: function () {
    this.$el.html(this.template());
    var view = new GoodInvests.Views.UsersIndex({ collection: this.users })
    this.current_view = view;
    this.addSubview("#display-list", view)
    return this;
  },

  initialize: function (options) {
    this.users = options.users;
    this.companies = options.companies;

    // this.listenTo( this.content, "sync", this.render)
  },

  events: {
    "click #show-users": "showUsers",
    "click #show-companies": "showCompanies"
  },

  showUsers: function (event) {
    if (this.current_view.$el.hasClass("user-list")) {
      return;
    }
    this.removeSubview("#display-list", this.current_view)
    var view = new GoodInvests.Views.UsersIndex({ collection: this.users })
    this.current_view = view;
    this.addSubview("#display-list", view)
  },

  showCompanies: function (event) {
    if (this.current_view.$el.hasClass("company-list")) {
      return;
    }
    this.removeSubview("#display-list", this.current_view)
    var view = new GoodInvests.Views.CompaniesIndex({ collection: this.companies })
    this.current_view = view;
    this.addSubview("#display-list", view)
  },

  tagName: "article"
})
