GoodInvests.Views.UsersIndex = Backbone.View.extend ({
  template:JST["sidebar/users_list"],

  render: function () {

    this.$el.html(this.template({ users: this.collection }));
    return this;
  },

  initialize: function () {
    this.listenTo( this.collection, "sync", this.render);
    this.$el.addClass("user-list")
  },

  tagName: "article"
})
