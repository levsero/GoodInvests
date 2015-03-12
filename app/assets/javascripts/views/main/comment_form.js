GoodInvests.Views.CommentForm = Backbone.View.extend ({
  template:JST["main_content/comment_form"],

  render: function () {
    this.$el.addClass("comment-form")
    // this.$el.html(this.template());

    if (this.session.is_loggedIn) {
      this.$el.addClass("comment-form")
      this.$el.html(this.template());
    } else {
      this.$el.html('<p class "message">Log in to join the conversation.</p>');
    }

    return this;
  },

  initialize: function (options) {
    this.$el.addClass("comments");
    this.session = options.session;

        this.listenTo(this.session, "loggedIn", this.render);
        this.listenTo(this.session, "signedOut", this.render);
  },

  events: {
    "submit": "postComment"
  },

  postComment: function (event) {
    event.preventDefault();

    attrs = $(event.currentTarget).serializeJSON();
    attrs.comment.commentable_id = this.model.id;
    attrs.comment.commentable_type = this.model.type;

    var comment = new GoodInvests.Models.Comment()
    comment.save(attrs, { success: function () {
        this.model.comments().add(comment, {merge: true})
      }.bind(this)
    })


  },

  tagName: "form",
})
