GoodInvests.Views.CompanyShow = Backbone.View.extend ({
  template:JST["main_content/company_show"],

  initialize: function (options) {
    this.session = options.session;
    this.listenTo( this.model, "sync change", this.render);
    this.$el.addClass("company-article");
    this.$el.addClass("group");
  },

  render: function () {
    this.$el.html(this.template({ company: this.model }));
    var view = new GoodInvests.Views.CommentsShow({ model: this.model, session: this.session })
    this.$el.append( view.render().$el )
    return this;
  },

  events: {
    "click button.follow": "followCompany",
    "click button.unfollow": "unfollowCompany",
  },

  followCompany: function (event) {
    event.preventDefault();
    var id = this.model.id;

    var follow = new GoodInvests.Models.Follow({
      followable_id: id,
      followable_type: "Company",
      follower_id: GoodInvests.session.current_user.id })

    follow.save({}, { success: function () {
      this.model.set({following: true});
      // this.model.trigger("sync");
      }.bind(this)
    })
  },

  unfollowCompany: function (event) {
    event.preventDefault();
    var followable_id = this.model.id;
    var id = GoodInvests.session.current_user.id

    $.ajax({
      url: "api/follows/" + id + "/" + followable_id +"/Company" ,
      type: "delete",
      success: function () {
        this.model.set({following: false});
        // this.model.trigger("sync");
      }.bind(this)
    });
  },

  tagName: "article"
})
