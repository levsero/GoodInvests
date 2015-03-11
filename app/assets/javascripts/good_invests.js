window.GoodInvests = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Backbone.history.start()
    var router = new GoodInvests.Routers.Router()
  }
};

$(document).ready(function(){
  GoodInvests.initialize();
});
