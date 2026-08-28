
class JobLocation {
  final String? locality;
  final String? region;
  final String? country;

  JobLocation({this.locality, this.region, this.country});

  factory JobLocation.fromJson(Map<String, dynamic> json) {
    final address = json['address'] as Map<String, dynamic>?;
    return JobLocation(
      locality: address?['addressLocality'],
      region: address?['addressRegion'],
      country: address?['addressCountry'],
    );
  }

  @override
  String toString() {
    return [
      locality,
      region,
      country,
    ].where((s) => s != null && s.isNotEmpty).join(', ');
  }
}
