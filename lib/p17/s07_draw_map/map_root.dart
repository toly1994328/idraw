import 'dart:convert' show json;

import 'package:flutter/cupertino.dart';

class MapRoot {
  String type;
  String name;
  List<Features> features;

  MapRoot({
    this.type,
    this.name,
    this.features,
  });

  static MapRoot fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Features> features = jsonRes['features'] is List ? [] : null;
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
  Properties properties;
  Geometry geometry;

  Features({
    this.type,
    this.properties,
    this.geometry,
  });

  static Features fromJson(jsonRes) => jsonRes == null
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
  List<double> center;
  List<double> centroid;
  int childrenNum;
  String level;
  Parent parent;
  int subFeatureIndex;
  List<int> acroutes;
  Object adchar;

  Properties({
    this.adcode,
    this.name,
    this.center,
    this.centroid,
    this.childrenNum,
    this.level,
    this.parent,
    this.subFeatureIndex,
    this.acroutes,
    this.adchar,
  });

  static Properties fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<double> center = jsonRes['center'] is List ? [] : null;
    if (center != null) {
      for (var item in jsonRes['center']) {
        if (item != null) {
          center.add(item);
        }
      }
    }

    List<double> centroid = jsonRes['centroid'] is List ? [] : null;
    if (centroid != null) {
      for (var item in jsonRes['centroid']) {
        if (item != null) {
          centroid.add(item);
        }
      }
    }

    List<int> acroutes = jsonRes['acroutes'] is List ? [] : null;
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
    this.adcode,
  });

  static Parent fromJson(jsonRes) => jsonRes == null
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
    this.type,
    this.coordinates,
  });

  static Geometry fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<List<List<Offset>>> coordinates = jsonRes['coordinates'] is List ? [] : null;
    if (coordinates != null) {
      for (var item0 in jsonRes['coordinates']) {
        if (item0 != null) {
          List<List<Offset>> items1 = [];
          for (var item1 in item0 is List ? item0 : []) {
            if (item1 != null) {
              List<Offset> items2 = [];
              for (var item2 in item1 is List ? item1 : []) {
                if (item2 != null) {
                  Offset items3 = Offset(item2[0],item2[1]);
                  items2.add(items3);
                }
                items1.add(items2);
              }
            }
            coordinates.add(items1);
          }
        }
      }
    }
    return Geometry(
      type: jsonRes['type'],
      coordinates: coordinates,
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
