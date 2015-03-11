window.GoodInvests = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new GoodInvests.Routers.Router()
    Backbone.history.start()
  }
};

$(document).ready(function(){
  GoodInvests.initialize();
});
