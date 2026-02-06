class HeroModel {
  final String response;
  String? id;
  final String name;
  final HeroPowerStats? powerstats;
  final HeroBiography? biography;
  final HeroAppearance? appearance;
  final HeroWork? work;
  final HeroConnection? connections;
  final HeroImage? image;

  HeroModel({
    required this.response,
    required this.id,
    required this.name,
    this.powerstats,
    this.biography,
    this.appearance,
    this.work,
    this.connections,
    this.image,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      response: json['response'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      powerstats: json['powerstats'] != null
          ? HeroPowerStats.fromJson(json['powerstats'])
          : null,
      biography: json['biography'] != null
          ? HeroBiography.fromJson(json['biography'])
          : null,
      appearance: json['appearance'] != null
          ? HeroAppearance.fromJson(json['appearance'])
          : null,
      work: json['work'] != null ? HeroWork.fromJson(json['work']) : null,
      connections: json['connections'] != null
          ? HeroConnection.fromJson(json['connections'])
          : null,
      image: json['image'] != null ? HeroImage.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'id': id,
      'name': name,
      'powerstats': powerstats?.toJson(),
      'biography': biography?.toJson(),
      'appearance': appearance?.toJson(),
      'work': work?.toJson(),
      'connections': connections?.toJson(),
      'image': image ?? {},
    };
  }
}

class HeroId {
  final String heroId;

  HeroId(this.heroId);

  factory HeroId.fromJson(Map<String, dynamic> json) {
    return HeroId(json['heroId']);
  }

  Map<String, dynamic> toJson() {
    return {'heroId': heroId};
  }
}

class HeroPowerStats {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  HeroPowerStats(
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
  );

  factory HeroPowerStats.fromJson(Map<String, dynamic> json) {
    return HeroPowerStats(
      json['intelligence'],
      json['strength'],
      json['speed'],
      json['durability'],
      json['power'],
      json['combat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'intelligence': intelligence,
      'strength': strength,
      'speed': speed,
      'durability': durability,
      'power': power,
      'combat': combat,
    };
  }
}

class HeroImage {
  final String url;

  HeroImage(this.url);

  factory HeroImage.fromJson(Map<String, dynamic> json) {
    return HeroImage(json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url};
  }
}

class HeroConnection {
  final String groupAffiliation;
  final String relative;

  HeroConnection(this.groupAffiliation, this.relative);

  factory HeroConnection.fromJson(Map<String, dynamic> json) {
    return HeroConnection(
      json['group-affiliation'] ?? '',
      json['relatives'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'group-affiliation': groupAffiliation, 'relatives': relative};
  }
}

class HeroWork {
  String occupation;
  String base;

  HeroWork(this.occupation, this.base);

  factory HeroWork.fromJson(Map<String, dynamic> json) {
    return HeroWork(json['occupation'] ?? '', json['base'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'occupation': occupation, 'base': base};
  }
}

class HeroAppearance {
  final String gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;

  HeroAppearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  factory HeroAppearance.fromJson(Map<String, dynamic> json) {
    List<String> heightList = [];
    if (json['height'] is List) {
      heightList = (json['height'] as List)
          .map((item) => item.toString())
          .toList();
    }

    List<String> weightList = [];
    if (json['weight'] is List) {
      weightList = (json['weight'] as List)
          .map((item) => item.toString())
          .toList();
    }

    return HeroAppearance(
      gender: json['gender'] ?? '',
      race: json['race'] ?? '',
      height: heightList,
      weight: weightList,
      eyeColor: json['eye-color'] ?? '',
      hairColor: json['hair-color'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'gender': gender,
    'race': race,
    'height': height,
    'weight': weight,
    'eye-color': eyeColor,
    'hair-color': hairColor,
  };
}

class HeroBiography {
  final String fullName;
  final List<String> alterEgo;
  final List<String> alias;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  HeroBiography(
    this.fullName,
    this.alterEgo,
    this.alias,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  );

  factory HeroBiography.fromJson(Map<String, dynamic> json) {
    List<String> alterEgos = [];
    if (json['alter-egos'] != null) {
      if (json['alter-egos'] is String) {
        alterEgos = [(json['alter-egos'] as String)];
      } else if (json['alter-egos'] is List) {
        alterEgos = List<String>.from(json['alter-egos']);
      }
    }

    List<String> aliases = [];
    if (json['aliases'] != null) {
      if (json['aliases'] is String) {
        aliases = [(json['aliases'] as String)];
      } else if (json['aliases'] is List) {
        aliases = List<String>.from(json['aliases']);
      }
    }

    return HeroBiography(
      json['full-name'] ?? '',
      alterEgos,
      aliases,
      json['place-of-birth'] ?? '',
      json['first-appearance'] ?? '',
      json['publisher'] ?? '',
      json['alignment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full-name': fullName,
      'alter-egos': alterEgo,
      'aliases': alias,
      'place-of-birth': placeOfBirth,
      'first-appearance': firstAppearance,
      'publisher': publisher,
      'alignment': alignment,
    };
  }
}
