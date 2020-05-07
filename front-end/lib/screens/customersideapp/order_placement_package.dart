class Package {
  int packageID;
  int companyID;
  int tankerCap;
  double basePrice;
  double price_per_km;

  Package(int companyID) {
    this.companyID = companyID;
  }

  Package.forPractice(
      int id, int companyID, int capacity, double basePrice, double pricekm) {
    this.basePrice = basePrice;
    this.companyID = companyID;
    this.packageID = id;
    this.tankerCap = capacity;
    this.price_per_km = pricekm;
  }

  void setTankerCap(int cap) {
    this.tankerCap = cap;
  }

  void setBasePrice(double price) {
    this.basePrice = price;
  }

  void setPriceKM(double price) {
    this.price_per_km = price;
  }
}
