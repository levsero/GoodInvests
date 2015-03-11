GoodInvests.Views.UserShow = Backbone.View.extend ({
  template:JST["main_content/user_show"],

  render: function () {
    this.$el.html(this.template({ user: this.model }));
    return this;
  },

  initialize: function () {
    this.listenTo( this.model, "sync", this.render);
    this.$el.addClass("user-article")
  },

  tagName: "article"
})
