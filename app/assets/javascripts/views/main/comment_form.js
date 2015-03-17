GoodInvests.Views.CommentForm = Backbone.View.extend ({
  template:JST["main_content/comment_form"],

  initialize: function (options) {
    this.$el.addClass("comments group");
    this.session = options.session;
    this.listenTo(this.session, "loggedIn", this.render);
    this.listenTo(this.session, "signedOut", this.render);
  },

  render: function () {
    this.$el.addClass("comment-form")
    // this.$el.html(this.template());
    if (this.session.isLoggedIn) {
      this.$el.addClass("comment-form")
      this.$el.html(this.template());
    } else {
      this.$el.html('<p class "message">Log in to join the conversation.</p>');
    }

    return this;
  },

  events: {
    "submit": "postcomment"
  },

  postcomment: function (event) {
    event.preventDefault();

    this.$el.find("#errors").empty();

    var that = this
    attrs = $(event.currentTarget).serializeJSON();
    attrs.comment.commentable_id = this.model.id;
    attrs.comment.commentable_type = this.model.type;

    var comment = new GoodInvests.Models.Comment()
    comment.save(attrs, { success: function () {
        this.model.comments().add(comment, {merge: true})
      }.bind(this),

      error: function (model, response, options) {
        _.each(response.responseJSON, function(error) {
          that.$el.find("#errors").append(error + "<br>" );
        })
      }
    })
  },

  tagName: "form",
})
