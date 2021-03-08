class Organization {
  int orgId;
  String name;
  String email;
  String description;
  String website;
  String streetAddress;
  String city;
  String province;
  String postalCode;
  int allocation;
  bool isActive;
  double lifeTimeDonation;

  Organization(
      {this.orgId,
      this.name,
      this.email,
      this.description,
      this.website,
      this.streetAddress,
      this.city,
      this.province,
      this.postalCode,
      this.allocation,
      this.isActive,
      this.lifeTimeDonation});

  int get getOrgId => orgId;
  String get getName => name;
  String get getEmail => email;
  String get getDescription => description;
  String get getWebsite => website;
  String get getStreetAddress => streetAddress;
  String get getCity => city;
  String get getProvince => province;
  String get getPostalCode => postalCode;
  int get getAllocation => allocation;
  bool get getIsActive => isActive;
  double get getLifeTimeDonation => lifeTimeDonation;

  set setAllocation(int allocation) => this.allocation = allocation;
}
