GoodInvests.Models.Session = Backbone.Model.extend ({
  initialize: function () {
    this.is_loggedIn = false;
    this.current_user = new GoodInvests.Models.User()

    $.ajax({
      url: "/api/logged_in",
      type: "get",
      success: function (data) {
        if(!data){
          this.is_loggedIn = false;
        } else {
          this.current_user.set(data.user)
          this.is_loggedIn = true;
          this.trigger("loggedIn");
        }
      }.bind(this)
    });
  },

  login: function (attrs) {
    $.ajax({
    url: "/api/session",
    type: "post",
    data: attrs,
    success: function (data) {
      $(".modal").removeClass("is-open");
      this.current_user.set(data.user)
      this.is_loggedIn = true;
      this.trigger("loggedIn");
      }.bind(this)
    });
  },

  signOut: function () {
    $.ajax({
      url: "/api/session",
      type: "delete",
      success: function () {
        this.is_loggedIn = false;
        this.current_user = new GoodInvests.Models.User()
        this.trigger("signedOut");
      }.bind(this)
    });
  }
})
