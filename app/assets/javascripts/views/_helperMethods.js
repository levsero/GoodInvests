GoodInvests.Views.HelperMethods = {
  message: function(message) {
    var elem = $('<message class="flash"> </message>')
    elem.html(message)
    this.$el.find("#holder").append(elem);
    var that = this;
    setTimeout( function(){that.$el.find(".flash").hide("blind", 500)}, 3000);
  },
}

// make sure this file is loaded first other files extend it.
