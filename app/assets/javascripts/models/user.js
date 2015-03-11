GoodInvests.Models.User = Backbone.Model.extend ({
  urlRoot: "api/users/",
  parse: function (payload) {
    if(payload.comments){
      this.comments().set(payload.comments)
    }
    return payload;
  },

  comments: function () {
    if (!this._comments) {
      this._comments = new GoodInvests.Collections.Comments();
    }
    return this._comments;
  }
})
