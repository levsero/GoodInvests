GoodInvests.Views.CommentShowItem = Backbone.View.extend ({
  template:JST["main_content/comment_show_item"],

  render: function () {
    this.$el.html(this.template({ comment: this.model }));
    return this;
  },

  initialize: function () {
    this.$el.addClass("comment-article group")
  },

  tagName: "li"
})
