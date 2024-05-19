import 'dart:ffi';

class Unit{
  String name;
  String imageUrl;
  String soundUrl;
  Unit({required this.name, required this.imageUrl, required this.soundUrl});


  Map<String, dynamic> toJson() => <String, dynamic>{
    "name": name,
    "image_url": imageUrl,
    "sound_url": soundUrl,
  };

  factory Unit.fromJson(Map<String?, dynamic> json) {
    return Unit(
      name: json['name'],
      imageUrl: json['image_url'],
      soundUrl: json['sound_url'],
    );
  }

  @override
  int get hashCode {
    return int.parse(name) * 45 +
        int.parse(imageUrl) * 45 +
        int.parse(soundUrl) * 45;
  }
}