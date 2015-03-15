GoodInvests.Views.CollectionListItem = Backbone.View.extend ({
  template:JST["sidebar/index_list_item"],

  render: function () {
    this.$el.html(this.template({ item: this.model }));
    return this;
  },

  initialize: function () {
    this.listenTo( this.model, "change sync", this.render);
    this.$el.addClass("list-item")
  },

  events: {
    "click button.follow": "followCompany",
    "click button.unfollow": "unfollowCompany",
  },

  followCompany: function (event) {
    event.preventDefault();
    var id = $(event.currentTarget).attr("data-id");

    var follow = new GoodInvests.Models.Follow({
      followable_id: id,
      followable_type: "Company",
      follower_id: GoodInvests.session.current_user.id })

    follow.save({}, { success: function () {
      this.collection.getOrFetch(id).set({following: true});
      }.bind(this)
    })
  },

  unfollowCompany: function (event) {
    event.preventDefault();
    var followable_id = $(event.currentTarget).attr("data-id");
    var id = GoodInvests.session.current_user.id

    $.ajax({
      url: "api/follows/" + id + "/" + followable_id +"/Company" ,
      type: "delete",
      success: function () {
        this.model.set({following: false});
      }.bind(this)
    });
  },

  tagName: "li"
})
