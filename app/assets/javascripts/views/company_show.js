GoodInvests.Views.CompanyShow = Backbone.View.extend ({
  template:JST["main_content/company_show"],

  render: function () {
    this.$el.html(this.template({ company: this.model }));
    return this;
  },

  initialize: function () {
    this.listenTo( this.model, "sync", this.render);
    this.$el.addClass("company-article")
  },

  tagName: "article"
})
