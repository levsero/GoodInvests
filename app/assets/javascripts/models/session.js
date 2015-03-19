GoodInvests.Models.Session = Backbone.Model.extend ({
  initialize: function () {
    this.isLoggedIn = false;
    this.current_user = new GoodInvests.Models.User();

    $.ajax({
      url: "/api/logged_in",
      type: "get",
      success: function (data) {
        if(!data){
          this.isLoggedIn = false;
        } else {

          this.isLoggedIn = true;
          this.trigger("loggedIn");

          if(data.notifications){
            this.current_user.notifications().set(data.notifications)
            delete data.notifications
          }

          this.current_user.set(data)
          this.trigger("loggedIn");

        }
      }.bind(this)
    });
  },

  login: function (attrs, callback, errorCallback) {
    $.ajax({
      url: "/api/session",
      type: "post",
      data: attrs,

      success: function (data) {
        $(".modal").removeClass("is-open");
        this.current_user.set(data)
        this.isLoggedIn = true;
        this.trigger("loggedIn");
        callback();
      }.bind(this),

      error: function (response) {
        errorCallback(response)
      }
    });
  },

  signOut: function () {
    $.ajax({
      url: "/api/session",
      type: "delete",
      success: function () {
        this.isLoggedIn = false;
        this.current_user = new GoodInvests.Models.User()
        this.trigger("signedOut");
      }.bind(this)
    });
  },

  newUser: function () {
    this.trigger("newUser");
  }
})
