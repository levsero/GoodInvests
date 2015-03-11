GoodInvests.Views.Sidebar = Backbone.CompositeView.extend ({
  template:JST["sidebar/sidebar"],

  render: function () {
    this.$el.html(this.template());
    var view = new GoodInvests.Views.UsersIndex({ collection: this.users })
    this.current_view = view;
    this.addSubview("ul", view)
    return this;
  },

  initialize: function (options) {
    this.users = options.users;
    this.companies = options.companies;

    // this.listenTo( this.model, "add delete sync", this.render)
  },

  events: {
    "click #show-users": "showUsers",
    "click #show-companies": "showCompanies"
  },

  showUsers: function (event) {
    if (this.current_view.$el.hasClass("user-list")) {
      return;
    }
    this.removeSubview("ul", this.current_view)
    var view = new GoodInvests.Views.UsersIndex({ collection: this.users })
    this.current_view = view;
    this.addSubview("ul", view)
  },

  showCompanies: function (event) {
    if (this.current_view.$el.hasClass("company-list")) {
      return;
    }
    this.removeSubview("ul", this.current_view)
    var view = new GoodInvests.Views.CompaniesIndex({ collection: this.companies })
    this.current_view = view;
    this.addSubview("ul", view)
  },

  tagName: "article"
})
