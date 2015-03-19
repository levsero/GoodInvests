GoodInvests.Collections.Notifications = Backbone.Collection.extend ({
  model: GoodInvests.Models.Notification,

  url: "api/notifications",

  comparator: function (notification) {
    return -Date.parse(notification.get("created_at"))
  },

  initialize: function () {
    this.pageInfo = {"current": 0};
  },

  parse: function (data) {
    return data.notifications
  }
})
