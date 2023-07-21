class Package {
  String appName;
  String packageName;
  String versionName;

  Package(
      {required this.appName, required this.packageName, required this.versionName});

  factory Package.fromJson(Map<String, dynamic> json) =>
      Package(appName: json['name'],
          packageName: json['packageName'],
          versionName: json['versionCode']);
}