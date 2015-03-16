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
    }
  },

  parse: function (payload) {
    if (payload.comparator) {
      this.comparator = payload.comparator
      delete payload.comparator
    }

    this.pageInfo = payload.page;
    delete payload.page;
    return payload["companies"];
  },
})
