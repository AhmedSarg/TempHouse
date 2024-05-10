import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

import '../../../app/constants.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream<List<Map<String, dynamic>>> getUserStreamOrdered() {
  //   return _firestore.collection("Users")
  //       .orderBy('lastMessageTime', descending: true) // Order by lastMessageTime
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       final user = doc.data();
  //       return {
  //         ...user,
  //         'lastMessage': user['lastMessage'] ?? '',
  //         'lastMessageTime': user['lastMessageTime'] ?? '',
  //       };
  //     }).toList();
  //   });
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserStreamOrdered() {
    return _firestore
        .collection("chat_rooms")
        .where('participants_names', arrayContains: DataIntent.getUser().name)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String id) {
    return _firestore
        .collection("chat_rooms")
        .doc(id)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc.data()['senderID'] != DataIntent.getUser().uid) {
          doc.reference.update({'seen': true});
        }
      }
      return snapshot;
    });
  }

  Future<void> sendMessage(
      String chatRoomID,
      String content,
      String type,
      Timestamp timestamp,
      ) async {
    Map<String, dynamic> messageData = {
      'senderID': DataIntent.getUser().uid,
      'content': content,
      'timestamp': timestamp,
      'type': type,
      'seen': false,
    };

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .add(messageData);
  }


  // Stream<QuerySnapshot> getMessages(String chatID) {
  //   return _firestore
  //       .collection("chat_rooms")
  //       .doc(chatID)
  //       .collection('messages')
  //       .orderBy('timestamp', descending: false)
  //       .snapshots()
  //       .map((snapshot) {
  //     snapshot.docs.forEach((doc) {
  //         doc.reference.update({'seen': true});
  //
  //     });
  //     return snapshot;
  //   });
  // }

  String getChatRoomID(String currentUserID, String otherUserID) {
    List<String> ids = [currentUserID, otherUserID];
    ids.sort();
    return ids.join('_');
  }

  String formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat('MMM d, h:mm a').format(dateTime);
    } else {
      return '';
    }
  }
}
