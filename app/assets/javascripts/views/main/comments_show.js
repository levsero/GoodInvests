GoodInvests.Views.CommentsShow = Backbone.View.extend ({
  template:JST["main_content/comments_show"],

  render: function () {
    this.$el.html(this.template());

    this.model.comments().each( function (comment){
      var view = new GoodInvests.Views.CommentShowItem({model: comment});
      this.$el.find("ul").append(view.render().$el)
    }.bind(this))

    if (this.model.logged_in) {
      var view = new GoodInvests.Views.CommentForm({model: this.model});
      this.$el.find("ul").append(view.render().$el);
    } else {
      this.$el.find("ul").append('<p class "message">Log in to join the conversation.</p>');
    }

    return this;
  },

  initialize: function () {
    this.listenTo( this.model, "sync", this.render);
    this.listenTo( this.model.comments(), "add", this.render);
    this.$el.addClass("comments")
  },

  tagName: "comments"
})
