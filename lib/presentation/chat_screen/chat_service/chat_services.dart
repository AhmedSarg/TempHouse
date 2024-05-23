import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temp_house/presentation/common/data_intent/data_intent.dart';

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

  Stream<List<Map<String, dynamic>>> getUserStreamOrdered() {
    return _firestore
        .collection("chat_rooms")
        .where(
          'participants_names',
          arrayContains: DataIntent.getUser().username,
        )
        .snapshots()
        .map(
          (chats) => chats.docs.map(
            (chat) {
              Map<String, dynamic> ret = chat.data();
              ret['id'] = chat.id;
              return ret;
            },
          ).toList(),
        );
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
    DocumentReference chatRoomRef =
        _firestore.collection("chat_rooms").doc(chatRoomID);
    bool exists = await chatRoomRef.get().then(
      (chatRoom) {
        return chatRoom.data() != null;
      },
    );
    if (!exists) {
      List<String> ids = chatRoomID.split('_');
      List<String> names = [];
      print(ids);
      await _firestore.collection('users').doc(ids[0]).get().then((value) {
        names.add(value.data()!['username']);
      });
      await _firestore.collection('users').doc(ids[1]).get().then((value) {
        names.add(value.data()!['username']);
      });
      await chatRoomRef.set(
        {
          'participants_names': names,
          'participants_ids': ids,
        },
      );
    }
    await chatRoomRef.collection('messages').add(messageData);
    await chatRoomRef.update({
      'last_message': content.contains(
              'https://firebasestorage.googleapis.com/v0/b/temp-house.appspot.com/o/')
          ? 'Photo Message'
          : content,
      'last_message_date': DateTime.now(),
    });
  }

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
