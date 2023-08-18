class Contact {
  String displayName;
  String phone;

  Contact({required this.displayName, required this.phone});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      Contact(displayName: json['other_name'], phone: json['other_mobile']);
}
