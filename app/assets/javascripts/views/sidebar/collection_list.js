GoodInvests.Views.CollectionList = Backbone.View.extend ({
  template:JST["sidebar/collection_list"],

  initialize: function () {
    this.pageInfo = this.collection.pageInfo;
    this.listenTo( this.collection, "sync change", this.render);
    this.listenTo( this.collection, "add", this.add);
    this.listenTo(GoodInvests.session, "loggedIn", this.render);
    this.listenTo(GoodInvests.session, "newUser", this.refetch);
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

  refetch: function () {
    if (this.collection instanceof GoodInvests.Collections.Users) {
      this.collection.fetch({
        data: {
          page: this.collection.pageInfo.num_pages
        }
      });
    }
  },

  add: function () {
    this.$el.html(this.template({userShow : this.model, page: this.collection.pageInfo }));
    this.collection.each( function (item) {
      var view = new GoodInvests.Views.CollectionListItem({
        collection: this.collection, model: item
      })
      this.$el.prepend(view.render().$el)
    }.bind(this))
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
      }
    });
  },

  prevPage: function (event) {
    this.pageInfo = this.collection.pageInfo;
    if (this.pageInfo.current === 1 ) {
      return;
    }

    this.collection.fetch({
      data: {
        page: this.pageInfo.current - 1
      }
    });
  },

  tagName: "ul"
})
