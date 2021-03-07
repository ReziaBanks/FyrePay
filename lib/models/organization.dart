class Organization {
  int _orgId;
  String _name;
  String _email;
  String _description;
  String _website;
  String _streetAddress;
  String _city;
  String _province;
  String _postalCode;
  int _allocation;
  bool _isActive;
  double _lifeTimeDonation;

  Organization(
      this._orgId,
      this._name,
      this._email,
      this._description,
      this._website,
      this._streetAddress,
      this._city,
      this._province,
      this._postalCode,
      this._allocation,
      this._isActive,
      this._lifeTimeDonation);

  int get orgId => _orgId;
  String get name => _name;
  String get email => _email;
  String get description => _description;
  String get website => _website;
  String get streetAddress => _streetAddress;
  String get city => _city;
  String get province => _province;
  String get postalCode => _postalCode;
  int get allocation => _allocation;
  bool get isActive => _isActive;
  double get lifeTimeDonation => _lifeTimeDonation;

  set setAllocation(int allocation) => _allocation = allocation;
}
