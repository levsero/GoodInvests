GoodInvests.Views.UserShow = Backbone.View.extend ({
  template:JST["main_content/user_show"],

  render: function () {
    this.$el.html(this.template({ user: this.model }));
    var view = new GoodInvests.Views.CommentsShow({ model: this.model })
    this.$el.append( view.render().$el )
    return this;
  },

  initialize: function () {
    this.listenTo( this.model, "sync", this.render);
    this.$el.addClass("user-article")
  },

  events: {
    "dblclick .profile li": "editField",
    "blur input": "saveProfile"
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
    var type = $(event.currentTarget).parent().attr("data-type")
    var value = $(event.currentTarget).val();
    var attrs = {};
    attrs[type] = value;
    this.model.save(attrs);
  },

  tagName: "article"
})
