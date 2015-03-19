GoodInvests.Collections.Comments = Backbone.Collection.extend ({
  model: GoodInvests.Models.Comment,
  comparator: function (comment) {
    return -Date.parse(comment.get("created_at"))
  }
})
