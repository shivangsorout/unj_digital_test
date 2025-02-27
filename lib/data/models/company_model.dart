class Company {
  static const String keyName = 'name';
  static const String keyCatchPhrase = 'catchPhrase';
  static const String keyBs = 'bs';

  final String name;
  final String catchPhrase;
  final String bs;

  Company({required this.name, required this.catchPhrase, required this.bs});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json[keyName] ?? '',
      catchPhrase: json[keyCatchPhrase] ?? '',
      bs: json[keyBs] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {keyName: name, keyCatchPhrase: catchPhrase, keyBs: bs};
  }
}
