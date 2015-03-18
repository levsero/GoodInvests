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

  comparator: function (company) {
    if (this.comparator) {
      return company.get(this.comparator)
    } else {
      return this.escape("name")
    }
  },

  parse: function (payload) {
    this.pageInfo = payload.page;
    delete payload.page;
    return payload["companies"];
  },

  initialize: function (options) {
    this.comparator = options ? options.comparator : "name"
  }
})
