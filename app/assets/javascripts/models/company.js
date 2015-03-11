GoodInvests.Models.Company = Backbone.Model.extend ({
  urlRoot: "api/companies/",

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
  },

  initialize: function () {
    this.type = "Company"
  }
})
