window.GoodInvests = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    GoodInvests.session = new GoodInvests.Models.Session();
    var router = new GoodInvests.Routers.Router()
    Backbone.history.start()
  }
};

$(document).ready(function(){
  GoodInvests.initialize();
});
