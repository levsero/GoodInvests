GoodInvests.Views.CompaniesIndex = Backbone.View.extend ({
  template:JST["sidebar/companies_list"],

  render: function () {
    console.log("render")
    this.$el.html(this.template({ companies: this.collection }));
    return this;
  },

  initialize: function () {
    this.listenTo( this.collection, "sync", this.render);
    this.listenTo( GoodInvests.session, "sync", this.render);
    this.$el.addClass("company-list")
  },

  tagName: "ul"
})