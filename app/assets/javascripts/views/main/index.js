GoodInvests.Views.Index = Backbone.View.extend ({
  template:JST["main_content/index"],

  initialize: function (options) {
    this.$el.addClass("index group");
    // this.$el.addClass("group");
    this.followedCompanies = new GoodInvests.Collections.Companies({comparator: "count"});
    this.commenedCompanies = new GoodInvests.Collections.Companies({comparator: "count"});
    $.ajax({
      url: "/api/most_followed",
      type: "get",
      success: function (data) {
        this.followedCompanies.set(data.most_followed);
        this.commenedCompanies.set(data.most_commened);
      }.bind(this)
    });
  },

  render: function () {
    this.$el.html(this.template());
    var view = new GoodInvests.Views.CollectionList({ collection: this.followedCompanies })
    this.$el.find("ul.most-followed").append(view.render().$el)

    view = new GoodInvests.Views.CollectionList({ collection: this.commenedCompanies })
    this.$el.find("ul.most-commened").append(view.render().$el)
    return this;
  },

  events: {

  },




  tagName: "article"
})
