GoodInvests.Views.CompanyShow = Backbone.View.extend ({
  template:JST["main_content/company_show"],

  render: function () {
    this.$el.html(this.template({ company: this.model }));
    var view = new GoodInvests.Views.CommentsShow({ model: this.model, session: this.session })
    this.$el.append( view.render().$el )
    return this;
  },

  initialize: function (options) {
    this.session = options.session;
    this.listenTo( this.model, "sync", this.render);
    this.$el.addClass("company-article");
    this.$el.addClass("group");
  },

  tagName: "article"
})
