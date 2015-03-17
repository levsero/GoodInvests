GoodInvests.Views.CompanyShow = Backbone.View.extend ({
  template:JST["main_content/company_show"],

  initialize: function (options) {
    this.session = options.session;
    this.listenTo( this.model, "sync change", this.render);
    this.listenTo( GoodInvests.session, "loggedIn", this.raty);
    this.listenTo( GoodInvests.session, "signedOut", this.raty);
    this.$el.addClass("company-article");
    this.$el.addClass("group");
  },

  render: function () {
    this.$el.html(this.template({ company: this.model }));
    var view = new GoodInvests.Views.CommentsShow({ model: this.model, session: this.session })
    this.$el.append( view.render().$el )

    this.raty();

    return this;
  },

  raty: function () {
    var that = this;
    var id = this.model.id;

    var callback = function(score) {
        // custom route to update current users rating of model
      $.ajax({
        url: "api/ratings/",
        type: "post",
        data: { rating: { rateable_id: id, rateable_type: "Company", rating: score}},
        success: function () {
          that.model.set({ rating: score });
          // this.model.trigger("sync");
        }.bind(this)
      });
    }

    $('div.raty').raty({
      score: this.model.escape("rating"),
      click: callback,
      path: 'images',
      readOnly: function() {
        return GoodInvests.session.isLoggedIn == false;
      }
    });
  },

  events: {
    "click button.follow": "followCompany",
    "click button.unfollow": "unfollowCompany",
    "click div.raty": "setStars"
  },

  setStars: function (event) {
    console.log("clicked")
    var that = this;
    var id = this.model.id;

    var callback = function(score) {
        // custom route to update current users rating of model
        $.ajax({
          url: "api/ratings/",
          type: "post",
          data: { rateable_id: id, rateable_type: "Company", rating: score},
          success: function () {
            this.model.set({ rating: score });
            // this.model.trigger("sync");
          }.bind(this)
        });
      }
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
