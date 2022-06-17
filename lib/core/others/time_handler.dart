

import 'package:uuid/uuid.dart';

String uid(){
  var uuid = Uuid();
  return uuid.v1(options: {
    'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
    'clockSeq': 0x1234,
    'mSecs': DateTime.utc(2011, 11, 01).millisecondsSinceEpoch,
    'nSecs': 5678
  });
}