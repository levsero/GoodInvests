GoodInvests.Views.UserShow = Backbone.View.extend ({
  template:JST["main_content/user_show"],

  initialize: function (options) {
    this.session = options.session
    this.listenTo( this.model, "sync", this.render);
    this.listenTo( GoodInvests.session, "loggedIn", this.render);
    this.listenTo( GoodInvests.session, "signedOut", this.render);
    this.$el.addClass("user-article");
    this.$el.addClass("group");
  },

  render: function () {
    this.$el.html(this.template({ user: this.model }));

    var portfolio = new GoodInvests.Views.CollectionList({
      model: this.model,
      collection: this.model.companies()}
    );
    this.$el.find(".portfolio").append(portfolio.render().$el);

    var commentsView = new GoodInvests.Views.CommentsShow({ model: this.model, session: this.session })
    this.$el.find("#profile-items").append(commentsView.render().$el);

    this.raty();

    return this;
  },

  events: {
    "dblclick .profile li.edit": "editField",
    "blur .edit input": "saveProfile",
    "submit form#img": "savePicture",
    "change #input-picture-file": "changePicture",
    "click div.raty": "setStars"
  },

  editField: function (event) {
    if (!this.model.id == GoodInvests.session.current_user.id) {
      return
    }

    $field = $(event.currentTarget).find("span")
    var $input = $('<input type="text">');
    $field.removeClass("editable")
    $input.val($field.text());
    $field.html($input);
    $input.focus()
  },

  saveProfile: function (event) {
    event.preventDefault();
    var type = $(event.currentTarget).parent().attr("data-type")
    var value = $(event.currentTarget).val();
    var attrs = {};

    attrs[type] = value;
    this.model.save(attrs);
  },

  changePicture: function (event) {
    var file = event.currentTarget.files[0];
    var fileReader = new FileReader();

    fileReader.onloadend = function () {
      this.model.set("picture", fileReader.result);
      // this.previewPic(fileReader.result);
    }.bind(this);

    fileReader.readAsDataURL(file);
  },

  savePicture: function (event) {
    event.preventDefault();

    var data = $(event.currentTarget).serializeJSON
    this.model.save(data)
  },

  raty: function () {
    var that = this;
    var id = this.model.id;
    console.log(typeof this.model)

    var callback = function(score) {
      // custom route to update current users rating of model
      $.ajax({
        url: "api/ratings/",
        type: "post",
        data: { rating: { rateable_id: id, rateable_type: "User", rating: score}},
        success: function () {
          that.model.set({ rating: score });
          that.message("Thank you for rating this user")
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

  tagName: "article"
})

_.extend(GoodInvests.Views.UserShow.prototype, GoodInvests.Views.HelperMethods)
