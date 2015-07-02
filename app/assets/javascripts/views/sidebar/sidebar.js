GoodInvests.Views.Sidebar = Backbone.CompositeView.extend ({
  template:JST["sidebar/sidebar"],

  render: function () {
    this.$el.html(this.template());
    var view = new GoodInvests.Views.CollectionList({ collection: this.users })

    if (this.current_view) {
      this.removeSubview(this.current_view)
    }
    this.current_view = view;
    this.addSubview("#display-list", view)
    return this;
  },

  initialize: function (options) {
    this.page = 1
    this.users = options.users;
    this.companies = options.companies;

    this.searchResults = new GoodInvests.Collections.SearchResults();
    this.listenTo( this.searchResults, "sync", this.showSearch)
  },

  events: {
    "change #query": "search",
    "click #show-users": "showUsers",
    "click #show-companies": "showCompanies"
  },

  showUsers: function (event) {
    if (this.current_view.$el.hasClass("user-list")) {
      return;
    }
    this.swap_views( this.users )
  },

  showCompanies: function (event) {
    if (this.current_view.$el.hasClass("company-list")) {
      return;
    }
    this.swap_views( this.companies )
  },

  showSearch: function (event) {
    this.swap_views( this.searchResults )
  },

  search: function (event) {
    event.preventDefault();

    query = this.$("#query").val();
    this.$("#query").val("")
    this.searchResults.fetch({
      data: {
        query: query,
        page: 1
      }
    });
  },

  swap_views: function (collection) {
    this.removeSubview("#display-list", this.current_view)
    var view = new GoodInvests.Views.CollectionList({ collection: collection })
    this.current_view = view;
    this.addSubview("#display-list", view)
  },

  tagName: "article"
})
