GoodInvests.Views.CommentsShow = Backbone.View.extend ({
  template:JST["main_content/comments_show"],

  render: function () {
    this.$el.html(this.template());
    this.collection.each( function (comment){
      var view = new GoodInvests.Views.CommentShowItem({model: comment});
      this.$el.find("ul").append(view.render().$el)
    }.bind(this))

    return this;
  },

  initialize: function () {
    this.listenTo( this.collection, "sync", this.render);
    this.$el.addClass("comments")
  },

  tagName: "comments"
})
