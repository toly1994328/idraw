import 'dart:convert' show json;

import 'package:flutter/cupertino.dart';

class MapRoot {
  String type;
  String name;
  List<Features?>? features;

  MapRoot({
   required this.type,
    required this.name,
    required this.features,
  });

  static MapRoot? fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Features?>? features = jsonRes['features'] is List ? [] : null;
    if (features != null) {
      for (var item in jsonRes['features']) {
        if (item != null) {
          features.add(Features.fromJson(item));
        }
      }
    }
    return MapRoot(
      type: jsonRes['type'],
      name: jsonRes['name'],
      features: features,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'features': features,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Features {
  String type;
  Properties? properties;
  Geometry? geometry;

  Features({
   required this.type,
   required this.properties,
   required this.geometry,
  });

  static Features? fromJson(jsonRes) => jsonRes == null
      ? null
      : Features(
          type: jsonRes['type'],
          properties: Properties.fromJson(jsonRes['properties']),
          geometry: Geometry.fromJson(jsonRes['geometry']),
        );

  Map<String, dynamic> toJson() => {
        'type': type,
        'properties': properties,
        'geometry': geometry,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Properties {
  String adcode;
  String name;
  List<double>? center;
  List<double>? centroid;
  int childrenNum;
  String level;
  Parent? parent;
  int subFeatureIndex;
  List<int>? acroutes;
  Object adchar;

  Properties({
   required this.adcode,
   required this.name,
   required this.center,
   required this.centroid,
   required this.childrenNum,
   required this.level,
   required this.parent,
   required this.subFeatureIndex,
   required this.acroutes,
   required this.adchar,
  });

  static Properties? fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<double>? center = jsonRes['center'] is List ? [] : null;
    if (center != null) {
      for (var item in jsonRes['center']) {
        if (item != null) {
          center.add(item);
        }
      }
    }

    List<double>? centroid = jsonRes['centroid'] is List ? [] : null;
    if (centroid != null) {
      for (var item in jsonRes['centroid']) {
        if (item != null) {
          centroid.add(item);
        }
      }
    }

    List<int>? acroutes = jsonRes['acroutes'] is List ? [] : null;
    if (acroutes != null) {
      for (var item in jsonRes['acroutes']) {
        if (item != null) {
          acroutes.add(item);
        }
      }
    }
    return Properties(
      adcode: jsonRes['adcode'],
      name: jsonRes['name'],
      center: center,
      centroid: centroid,
      childrenNum: jsonRes['childrenNum'],
      level: jsonRes['level'],
      parent: Parent.fromJson(jsonRes['parent']),
      subFeatureIndex: jsonRes['subFeatureIndex'],
      acroutes: acroutes,
      adchar: jsonRes['adchar'],
    );
  }

  Map<String, dynamic> toJson() => {
        'adcode': adcode,
        'name': name,
        'center': center,
        'centroid': centroid,
        'childrenNum': childrenNum,
        'level': level,
        'parent': parent,
        'subFeatureIndex': subFeatureIndex,
        'acroutes': acroutes,
        'adchar': adchar,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Parent {
  int adcode;

  Parent({
   required this.adcode,
  });

  static Parent? fromJson(jsonRes) => jsonRes == null
      ? null
      : Parent(
          adcode: jsonRes['adcode'],
        );

  Map<String, dynamic> toJson() => {
        'adcode': adcode,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Geometry {
  String type;
  List<List<List<Offset>>> coordinates;

  Geometry({
   required this.type,
   required this.coordinates,
  });

  static Geometry? fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<List<List<Offset>>>? coordinates =
        jsonRes['coordinates'] is List ? [] : null;

    bool fourLever =false;
    if (jsonRes['coordinates'] is List) {
      if (jsonRes['coordinates'][0] is List){
        if (jsonRes['coordinates'][0][0] is List){
          if (jsonRes['coordinates'][0][0][0] is List){
            fourLever =true;
          }
        }
      }
    }

    if(!fourLever){
      if (coordinates != null) {
        for (var level0 in jsonRes['coordinates']) {
          List<List<Offset>> lever0=[];
          if (level0 != null) {
            List<Offset> items1 = [];
            for (var item1 in level0 is List ? level0 : []) {
              if (item1 != null) {
                Offset items2 = Offset(item1[0], item1[1]);
                items1.add(items2);
              }
              lever0.add(items1);
            }
          }
          coordinates.add(lever0);
        }
      }
    }else{
      if (coordinates != null) {
        for (var level0 in jsonRes['coordinates']) {
          if (level0 != null) {
            List<List<Offset>> items1 = [];
            for (var item1 in level0 is List ? level0 : []) {
              if (item1 != null) {
                List<Offset> items2 = [];
                for (var item2 in item1 is List ? item1 : []) {
                  if (item2 != null && item2 is List) {
                    Offset items3 = Offset(item2[0], item2[1]);
                    items2.add(items3);
                  } else {
                    items2.add(Offset.zero);
                  }
                  items1.add(items2);
                }
              }
              coordinates.add(items1);
            }
          }
        }
      }
    }


    return Geometry(
      type: jsonRes['type'],
      coordinates: coordinates??[],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
