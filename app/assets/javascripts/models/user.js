GoodInvests.Models.User = Backbone.Model.extend ({
  urlRoot: "api/users/",
  parse: function (payload) {
    if(payload.comments){
      this.comments().set(payload.comments)
      delete payload.comments
    }
    if(payload.portfolio){
      this.companies().set(payload.portfolio)
      delete payload.portfolio
    }
    return payload;
  },

  toJSON: function () {
    return {
      user: _.clone(this.attributes)
    };
  },

  comments: function () {
    if (!this._comments) {
      this._comments = new GoodInvests.Collections.Comments();
    }
    return this._comments;
  },

  companies: function () {
    if (!this._companies) {
      this._companies = new GoodInvests.Collections.Companies();
    }
    return this._companies;
  },

  initialize: function () {
    this.type = "User"
  }
})
