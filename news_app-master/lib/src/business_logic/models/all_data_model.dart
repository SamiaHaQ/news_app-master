class AllData {
  int cases = 0;
  int deaths = 0;
  int recovered = 0;
  int active = 0;

  AllData({this.cases,
        this.deaths,
        this.recovered,
        this.active
      });

  AllData.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    active = json['active'];
  }
}
