GoodInvests.Views.UserShow = Backbone.View.extend ({
  template:JST["main_content/user_show"],

  initialize: function (options) {
    this.session = options.session
    this.listenTo( this.model, "sync", this.render);
    this.$el.addClass("user-article");
    this.$el.addClass("group");
  },

  render: function () {
    this.$el.html(this.template({ user: this.model}));

    var portfolio = new GoodInvests.Views.CollectionList({
      model: this.model,
      collection: this.model.companies()}
      );
    this.$el.find(".portfolio").append(portfolio.render().$el);

    var commentsView = new GoodInvests.Views.CommentsShow({ model: this.model, session: this.session })
    this.$el.find("#profile-items").append(commentsView.render().$el);

    return this;
  },

  events: {
    "dblclick .profile li.edit": "editField",
    "blur .edit input": "saveProfile",
    "submit form#img": "savePicture",
    "change #input-picture-file": "changePicture"
  },

  editField: function (event) {
    if (!this.model.get("current_user")) {
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
  
  tagName: "article"
})
