GoodInvests.Views.Index = Backbone.View.extend ({
  template:JST["main_content/index"],

  initialize: function (options) {
    this.$el.addClass("index group");
    // this.$el.addClass("group");
    this.followedCompanies = new GoodInvests.Collections.Companies();
    $.ajax({
      url: "/api/most_followed",
      type: "get",
      success: function (data) {
        this.followedCompanies.set(data.most_followed);
      }.bind(this)
    });
  },

  render: function () {
    this.$el.html(this.template());
    var view = new GoodInvests.Views.CollectionList({ collection: this.followedCompanies })
    this.$el.find("ul.most-followed").append(view.render().$el)
    return this;
  },

  events: {

  },




  tagName: "article"
})
