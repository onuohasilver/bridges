import 'package:bridges/state/bridge_state.dart';

import 'package:flutter/cupertino.dart';

class BridgeState extends ChangeNotifier {
  final Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  ///Close the Bridge Instance AppWide
  ///This simply clears the bridge
  void close() {
    _data.clear();
    notifyListeners();
  }

  /// Closes the data Access to a parsed Key value
  void closeKey(String name) {
    _data.remove(name);
    notifyListeners();
  }

  ///Closes a list of Keys;
  /// Usually to make sure the state of a form is not preserved
  /// And all the entries return to their default set values
  void closeKeyList(List<String> names) {
    for (var element in names) {
      _data.remove(element);
    }
    notifyListeners();
  }

  ///Loads a parsed name slice pair into the memory
  void load(String name, dynamic slice, Type type,
      [bool override = true, bool exception = false]) {
    Type savedType = slice.runtimeType;

//checks if the type is same with the savedType if slice has been loaded previously into memory
    if (type != savedType) {
      throw ('Load' + BridgeErrors.unmatched(name, savedType, type));
    }
    if (override) {
      _data[name] = {'slice': slice, 'type': type};
    } else {
      if (exception) throw (BridgeErrors.cannotOverride);
    }

    notifyListeners();
  }

  ///updates a Map on the bridge
  void updateMap(String sliceName, MapEntry mapEntry) {
    if (_data.containsKey(sliceName)) {
      (_data[sliceName]['slice'] as Map)
          .addEntries([mapEntry].cast<MapEntry>());
    } else {
      Map cache = {};
      cache[mapEntry.key] = mapEntry.value;
      _data[sliceName] = {'slice': cache, 'type': Map};
    }
    notifyListeners();
  }

//checks if bridge already contains the key
  bool containsKey(String key) {
    return _data.containsKey(key);
  }

  ///Retrieves a previously saved bridge slice
  BridgeModel read(String name, dynamic initial) {
    //checks if the key "name" exists and then compares the types
    if (_data.containsKey(name)) {
      Type savedType = _data[name]['slice'].runtimeType;
      Type initialType = initial.runtimeType;
      if (initialType != savedType) {
        throw ('Read' + BridgeErrors.unmatched(name, savedType, initialType));
      }
      //returns bridgemodel if key exists and there is no type conflict
      return BridgeModel(_data[name]['slice'], _data[name]['type']);
    } else {
      //returns bridgemodel with initial and type
      return BridgeModel(initial, initial.runtimeType);
    }
  }

  ///reads a Map from Memory
  BridgeModel readMap(String mapName, dynamic fieldKey, dynamic initial) {
    Map cache = read(mapName, {}).slice;

    ///first checks if the provided key is already in memory
    if (cache.containsKey(fieldKey)) {
      //returns bridgemodel if key exists and there is no type conflict
      return BridgeModel(cache[fieldKey], cache[fieldKey].runtimeType);
    }
    //and if not it takes the type of the initial value
    else {
      //returns bridgemodel with initial and type
      return BridgeModel(initial, initial.runtimeType);
    }
  }
}
