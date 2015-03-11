GoodInvests.Collections.Companies = Backbone.Collection.extend ({
  url: "api/companies",

  model: GoodInvests.Models.Company,

  getOrFetch: function (id) {
    var company = this.get(id);
    if (!company) {
      company = new GoodInvests.Models.Company({"id": id});
    }
    company.fetch()
    return company;
  },

  parse: function (payload) {
    return payload["companies"];
  }
})
