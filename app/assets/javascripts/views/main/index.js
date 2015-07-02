GoodInvests.Views.Index = Backbone.View.extend ({
  template:JST["main_content/index"],

  initialize: function (options) {
    this.$el.addClass("index group");
    // this.$el.addClass("group");
    this.followedCompanies = new GoodInvests.Collections.Companies({comparator: "count"});
    this.commentedCompanies = new GoodInvests.Collections.Companies({comparator: "count"});

    // fill the company lists while loading
    for (var i=0; i < 9; i++) {
      this.followedCompanies.add(new GoodInvests.Models.Company({}));
      this.commentedCompanies.add(new GoodInvests.Models.Company({}));
    }

    $.ajax({
      url: "/api/most_followed",
      type: "get",
      success: function (data) {
        this.followedCompanies.set(data.most_followed);
        this.commentedCompanies.set(data.most_commented);
      }.bind(this)
    });
  },

  render: function () {
    this.$el.html(this.template());
    var view = new GoodInvests.Views.CollectionList({ collection: this.followedCompanies })
    this.$el.find("ul.most-followed").append(view.render().$el)

    view = new GoodInvests.Views.CollectionList({ collection: this.commentedCompanies })
    this.$el.find("ul.most-commented").append(view.render().$el)
    return this;
  },

  events: {

  },




  tagName: "article"
})
