GoodInvests.Views.CompaniesIndex = Backbone.View.extend ({
  template:JST["sidebar/companies_list"],

  render: function () {
    this.$el.html(this.template({ companies: this.collection }));
    this.collection.each( function (item) {
      var view = new GoodInvests.Views.CompaniesIndexItem({
        collection: this.collection, model: item
      })
      this.$el.append(view.render().$el)
    }.bind(this))
    return this;
  },

  initialize: function () {
    this.listenTo( this.collection, "sync change", this.render);
    this.listenTo(GoodInvests.session, "loggedIn", this.render);
    this.listenTo(GoodInvests.session, "signedOut", this.render);
    this.$el.addClass("company-list")
  },

  tagName: "ul"
})
