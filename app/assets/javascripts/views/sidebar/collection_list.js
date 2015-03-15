GoodInvests.Views.CollectionList = Backbone.View.extend ({
  template:JST["sidebar/collection_list"],

  initialize: function () {
    this.pageInfo = this.collection.pageInfo;
    this.listenTo( this.collection, "sync change", this.render);
    this.listenTo(GoodInvests.session, "loggedIn", this.render);
    this.listenTo(GoodInvests.session, "signedOut", this.render);
    this.$el.addClass("search-list")
  },

  render: function () {
    this.$el.html(this.template({userShow : this.model, page: this.collection.pageInfo }));
    this.collection.each( function (item) {
      var view = new GoodInvests.Views.CollectionListItem({
        collection: this.collection, model: item
      })
      this.$el.append(view.render().$el)
    }.bind(this))
    return this;
  },

  events: {
    "click #next": "nextPage",
    "click #prev": "prevPage",
  },

  nextPage: function (event) {
    this.pageInfo = this.collection.pageInfo;
    if (this.pageInfo.current === this.pageInfo.num_pages ) {
      return;
    }
    this.collection.fetch({
      data: {
        page: this.pageInfo.current + 1
      },
      success: function () {
        this.pageInfo.current++;
      }.bind(this)
    });
  },

  prevPage: function (event) {
    this.pageInfo = this.collection.pageInfo;
  
    if (this.pageInfo.current === 1 ) {
      return;
    }
    this.collection.fetch({
      data: {
        page: this.pageInfo - 1
      },
      success: function () {
        this.pageInfo.current--;
      }.bind(this)
    });
  },

  tagName: "ul"
})
