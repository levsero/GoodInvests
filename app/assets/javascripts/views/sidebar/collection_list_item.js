GoodInvests.Views.CollectionListItem = Backbone.View.extend ({
  template:JST["sidebar/index_list_item"],

  render: function () {
    this.$el.addClass("group")
    this.$el.html(this.template({ item: this.model }));
    if (GoodInvests.session.isLoggedIn  && this.model.get("following") == true) {
      this.$el.addClass("following")
    }
    return this;
  },

  initialize: function () {
    this.listenTo( this.model, "change sync", this.render);
    this.$el.addClass("list-item")
  },

  events : {
    "click .read": "markRead"
  },

  markRead: function (event) {
    event.preventDefault();
    this.model.save({},{
      success: function () {
        GoodInvests.session.current_user.set("notifications_count", this.model.collection.length-1)
        this.model.collection.remove(this.model);
      }.bind(this)
    })
  },

  tagName: "li"
})
