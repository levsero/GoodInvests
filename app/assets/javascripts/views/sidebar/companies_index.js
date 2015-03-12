GoodInvests.Views.CompaniesIndex = Backbone.View.extend ({
  template:JST["sidebar/companies_list"],

  render: function () {
    this.$el.html(this.template({ companies: this.collection }));
    return this;
  },

  initialize: function () {
    this.listenTo( this.collection, "sync", this.render);
    this.listenTo( GoodInvests.session, "sync", this.render);
    this.$el.addClass("company-list")
  },

  events: {
    "click button.follow": "followCompany",
    "click button.unfollow": "followCompany",
  },

  followCompany: function (event) {
    event.preventDefault();
    $(event.currentTarget).parent().attr("data-id");

  },

  tagName: "ul"
})
