import 'dart:developer';

import 'package:ambulancecheckup/main.dart';
import 'package:ambulancecheckup/models/car_model.dart';
import 'package:ambulancecheckup/models/user_model.dart';
import 'package:ambulancecheckup/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreAPIs {
  static Future<String?> createUser(
      {required String username, required String password}) async {
    UserModel userModel = UserModel(
        username: username, passwordEncrypted: encryptString(password));
    try {
      firestore?.collection('users').doc().set(userModel.toJson());
      return userModel.toJson().toString();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<UserModel?> checkUserExists(
      {required String username, required String encryptedPassword}) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .where('passwordEncrypted',
              isEqualTo: encryptString(encryptedPassword))
          .get();

      log(encryptString(encryptedPassword));

      return UserModel.fromDocumentSnapshot(querySnapshot.docs.first);
    } catch (e) {
      log('Error checking user existence: $e');
      return null;
    }
  }

  static Future<String?> createCar({required CarModel carModel}) async {
    try {
      firestore?.collection('cars').doc().set(carModel.toJson());
      return carModel.toJson().toString();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Stream<List<CarModel>> streamCars() {
    try {
      return FirebaseFirestore.instance
          .collection('cars')
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.map((doc) {
                return CarModel.fromDocument(doc.data());
              }).toList());
    } catch (e) {
      log('Error streaming cars: $e');
      return const Stream.empty();
    }
  }

  static Future<bool> updateCarReservation({
    required String carNumber,
    required String reservedBy,
    required String lastReservedDate,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cars')
          .where('carNumber', isEqualTo: carNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Car with the provided carNumber not found
        return false;
      }

      // Assuming there's only one document with a unique carNumber
      final carDoc = querySnapshot.docs.first.reference;

      await carDoc.update({
        'reservedBy': reservedBy,
        'lastReservedDate': lastReservedDate,
      });
      return true;
    } catch (e) {
      log('Error updating car reservation: $e');
      return false;
    }
  }
}

//   static Future<void> sendMessageInAChat({
//     String? chatId,
//     String? fromUid,
//     String? toUid,
//     String? message,
//     required String? fromImage,
//     required String? toImage,
//     required String? toFCMToken,
//     required String? fromFname,
//     required String? fromLname,
//   }) async {
//     // Create a document ID for the chat
//     // String chatId = '${fromUid}_$toUid';

//     // Create a document reference for the chat document
//     DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//     ChatModelDb chatModel = ChatModelDb(lastMessage: message);

//     Map<String, dynamic>? existingChatData = await chatRef
//         .get()
//         .then((snapshot) => snapshot.data() as Map<String, dynamic>?)
//         .catchError((error) => null);

//     Map<String, dynamic> chatData = chatModel.toJson();

//     if (existingChatData != null) {
//       // Update only non-null fields in chatData
//       chatData.forEach((key, value) {
//         if (value == null) {
//           chatData[key] = existingChatData[key];
//         }
//       });
//     }

//     if (chatData.isNotEmpty) {
//       await chatRef.set(chatData);
//     }

//     await chatRef.set(chatData);

//     // Create a message object

//     ChatMessage chatMessage = ChatMessage(
//         content: message ?? '',
//         isRead: false,
//         isSent: true,
//         timestamp: timeStampNow(),
//         response: '',
//         senderId: fromUid ?? '',
//         receiverId: toUid ?? '',
//         replyMessage: null);

//     // Create a map of the message object
//     Map<String, dynamic> messageData = chatMessage.toJson();

//     // Add the message to the chat document
//     await chatRef.collection('msglist').add(messageData);
//   }
//   // static Future<List<ChatModel>?> getAllUserChats(
//   //     {required List<String> userChatIds}) async {
//   //   List<ChatModel>? chatModels = [];
//   //   for (var chatId in userChatIds) {
//   //     try {
//   //       final DocumentSnapshot userDoc =
//   //           await firestore.collection('chats').doc(chatId).get();

//   //       if (userDoc.exists) {
//   //         print(ChatModel.fromJson(userDoc.data() as Map<String, dynamic>));
//   //         chatModels
//   //             .add(ChatModel.fromJson(userDoc.data() as Map<String, dynamic>));
//   //         // return FireStoreUserModel.fromJson(
//   //         //     userDoc.data() as Map<String, dynamic>);
//   //       } else {
//   //         return null; // User not found
//   //       }
//   //     } catch (e) {
//   //       print('Error getting user by ID: $e');
//   //       return null; // Handle error as needed
//   //     }
//   //   }

//   //   print(chatModels);
//   //   return chatModels;
//   // }
//   static Future<ChatModelDb?>? getChatModelDbFromListOfUsers(
//       {required List<UsersChat> listOfUserss}) async {
//     try {
//       final QuerySnapshot<Map<String, dynamic>> chatDocs = await firestore
//           .collection('chats')
//           // .where('id', isEqualTo: 'MbhZRpWZ2SXrkdeVFT2z')
//           .where('type', isEqualTo: 'direct')
//           .get();

//       List<ChatModelDb> convertQuerySnapshotToChatModelList(
//           QuerySnapshot<Map<String, dynamic>> chatDocs) {
//         return chatDocs.docs.map((doc) {
//           return ChatModelDb.fromJson(doc.data());
//         }).toList();
//       }

//       List<ChatModelDb> chatModelList =
//           convertQuerySnapshotToChatModelList(chatDocs);

//       for (ChatModelDb chatModel in chatModelList) {
//         print(jsonEncode(chatModel.users));
//         print(jsonEncode(chatModel.users));
//         if (jsonEncode(chatModel.users) == jsonEncode(chatModel.users)) {
//           return chatModel;
//         }
//       }

//       return null;
//     } catch (e) {
//       print('ERRORRR $e');
//       return null;
//     }
//   }

//   static bool areUsersListsEqual(
//       List<UsersChat>? usersInChat, List<UsersChat> targetUsers) {
//     if (usersInChat == null || usersInChat.length != targetUsers.length) {
//       return false;
//     }

//     // Check if the users lists match
//     return usersInChat.every((user) => targetUsers.contains(user));
//   }

//   // static bool areUsersListsEqual(List<UsersChat> list1, List<UsersChat> list2) {
//   //   if (list1.length != list2.length) {
//   //     return false; // Lists must have equal length
//   //   }
//   //   bool areUsersEqual(UsersChat user1, UsersChat user2) {
//   //     return user1.email == user2.email && user1.userId == user2.userId;
//   //   }

//   //   for (int i = 0; i < list1.length; i++) {
//   //     if (!areUsersEqual(list1[i], list2[i])) {
//   //       return false; // At least one pair of elements is not equal
//   //     }
//   //   }

//   //   return true; // All pairs of elements are equal
//   // }

//   static Future<void>? deleteChat({String? chatId}) async {
//     CollectionReference chatsCollection = firestore.collection('chats');
//     CollectionReference deletedChatsCollection =
//         firestore.collection('deleted-chats');

//     DocumentSnapshot chatSnapshot = await chatsCollection.doc(chatId).get();

//     if (chatSnapshot.exists) {
//       // Get the data from the snapshot
//       Map<String, dynamic> chatData =
//           chatSnapshot.data() as Map<String, dynamic>;

//       // Create a ChatModel instance from the data
//       ChatModelDb chatModel = ChatModelDb.fromJson(chatData);

//       // Add the chat to another collection
//       await deletedChatsCollection.add(chatModel.toJson());

//       // Delete the chat from the original collection
//       await chatsCollection.doc(chatId).delete();
//     } else {
//       // Handle the case where the chat does not exist
//       print('Chat with ID $chatId does not exist.');
//     }
//   }

//   static Future<void>? deleteChats({List<String>? chatIds}) async {
//     CollectionReference chatsCollection = firestore.collection('chats');
//     CollectionReference deletedChatsCollection =
//         firestore.collection('deleted-chats');

//     if (chatIds != null && chatIds.isNotEmpty) {
//       for (String chatId in chatIds) {
//         DocumentSnapshot chatSnapshot = await chatsCollection.doc(chatId).get();

//         if (chatSnapshot.exists) {
//           // Get the data from the snapshot
//           Map<String, dynamic> chatData =
//               chatSnapshot.data() as Map<String, dynamic>;

//           // Create a ChatModel instance from the data
//           ChatModelDb chatModel = ChatModelDb.fromJson(chatData);

//           // Add the chat to another collection
//           await deletedChatsCollection.add(chatModel.toJson());

//           // Delete the chat from the original collection
//           await chatsCollection.doc(chatId).delete();
//         } else {
//           // Handle the case where the chat does not exist
//           print('Chat with ID $chatId does not exist.');
//         }
//       }
//     } else {
//       // Handle the case where the list of chatIds is null or empty
//       print('List of chatIds is null or empty.');
//     }
//   }

//   // static Stream<List<ChatModelDb>?> getAllUserChatsStream({
//   //   required List<String> userChatIds,
//   //   required List<String> pinnedChatIds,
//   //   required List<String> archivedChatIds,
//   // }) async* {
//   //   List<ChatModelDb>? chatModels = [];
//   //   for (var chatId in userChatIds) {
//   //     try {
//   //       final DocumentSnapshot userDoc =
//   //           await firestore.collection('chats').doc(chatId).get();

//   //       print(userDoc.id);

//   //       if (userDoc.exists) {
//   //         print(ChatModelDb.fromJson(userDoc.data() as Map<String, dynamic>));
//   //         chatModels.add(
//   //             ChatModelDb.fromJson(userDoc.data() as Map<String, dynamic>));
//   //       } else {
//   //         yield null; // User not found
//   //       }
//   //     } catch (e) {
//   //       print('Error getting user by ID: $e');
//   //       yield null; // Handle error as needed
//   //     }
//   //   }

//   // chatModels.sort((a, b) {
//   //   bool isAPinned = pinnedChatIds.contains(a.id);
//   //   bool isBPinned = pinnedChatIds.contains(b.id);

//   //   if (isAPinned && !isBPinned) {
//   //     return -1;
//   //   } else if (!isAPinned && isBPinned) {
//   //     return 1;
//   //   } else {
//   //     // For non-pinned items, you can use another criterion for sorting
//   //     return b.lastMessageTime!.compareTo(a.lastMessageTime ?? '');
//   //   }
//   // });

//   // for (var theId in archivedChatIds) {
//   //   chatModels.removeWhere((element) => element.id == theId);
//   // }

//   //   print(chatModels);
//   //   yield chatModels;
//   // }

//   static Stream<List<ChatModelDb>> getAllUserChatsStream({
//     required List<String> userChatIds,
//     required List<String> pinnedChatIds,
//     required List<String> archivedChatIds,
//     required String userId,
//   }) {
//     final fromUidQuery = firestore
//         .collection('chats')
//         .where('userIds', arrayContains: userId)
//         .snapshots();

//     print(fromUidQuery);

//     return fromUidQuery
//         .asyncMap((QuerySnapshot<Map<String, dynamic>> fromUidSnapshot) {
//       print(fromUidSnapshot);
//       final List<QueryDocumentSnapshot<Map<String, dynamic>>> fromUidDocs =
//           fromUidSnapshot.docs;

//       print(fromUidDocs);

//       List<ChatModelDb> chatList = fromUidDocs
//           .map((doc) => ChatModelDb.fromDocumentSnapshot(doc))
//           .toList();

//       print(chatList);

//       chatList.sort((a, b) {
//         bool isAPinned = pinnedChatIds.contains(a.id);
//         bool isBPinned = pinnedChatIds.contains(b.id);

//         if (isAPinned && !isBPinned) {
//           return -1; // a should come before b
//         } else if (!isAPinned && isBPinned) {
//           return 1; // b should come before a
//         } else if (isAPinned && isBPinned) {
//           // Both are pinned, so sort by last message time
//           return b.lastMessageTime!.compareTo(a.lastMessageTime ?? '');
//         } else {
//           // Both are not pinned, so sort by last message time
//           return b.lastMessageTime!.compareTo(a.lastMessageTime ?? '');
//         }
//       });

//       // chatList.sort((a, b) {
//       //   bool isAPinned = pinnedChatIds.contains(a.id);
//       //   bool isBPinned = pinnedChatIds.contains(b.id);

//       //   if (isAPinned && !isBPinned) {
//       //     return -1;
//       //   } else if (!isAPinned && isBPinned) {
//       //     return 1;
//       //   } else {
//       //     // For non-pinned items, you can use another criterion for sorting
//       //     return b.lastMessageTime!.compareTo(a.lastMessageTime ?? '');
//       //   }
//       // });

//       // for (var theId in archivedChatIds) {
//       //   chatList.removeWhere((element) => element.id == theId);
//       // }

//       return chatList;
//     });
//   }

//   static Stream<List<ChatModelDb>?> getAllArchivedChatsStream({
//     required List<String> userChatIds,
//     required List<String> archivedChatIds,
//   }) async* {
//     List<ChatModelDb> chatModels = [];

//     try {
//       for (var chatId in userChatIds) {
//         final DocumentSnapshot userDoc =
//             await firestore.collection('chats').doc(chatId).get();

//         if (userDoc.exists) {
//           chatModels.add(
//               ChatModelDb.fromJson(userDoc.data() as Map<String, dynamic>));
//         }
//       }

//       // Filter chatModels to include only archived chats
//       chatModels = chatModels
//           .where((chat) => archivedChatIds.contains(chat.id))
//           .toList();

//       // Sort the chatModels based on lastMessageTime
//       chatModels.sort(
//           (a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime ?? ''));

//       yield chatModels;
//     } catch (e) {
//       print('Error fetching archived chats: $e');
//       yield null;
//     }
//   }

//   // static Stream<List<ChatModelDb>?> getAllArchivedChatsStream({
//   //   required List<String> userChatIds,
//   //   required List<String> archivedChatIds,
//   // }) async* {
//   //   List<ChatModelDb>? chatModels = [];
//   //   for (var chatId in userChatIds) {
//   //     try {
//   //       final DocumentSnapshot userDoc =
//   //           await firestore.collection('chats').doc(chatId).get();

//   //       print(userDoc.id);

//   //       if (userDoc.exists) {
//   //         print(ChatModelDb.fromJson(userDoc.data() as Map<String, dynamic>));

//   //         chatModels.add(
//   //             ChatModelDb.fromJson(userDoc.data() as Map<String, dynamic>));

//   //         print(chatModels);
//   //       } else {
//   //         yield null; // User not found
//   //       }
//   //     } catch (e) {
//   //       print('Error getting user by ID: $e');
//   //       yield null; // Handle error as needed
//   //     }
//   //   }

//   //   chatModels.sort((a, b) {
//   //     bool isAPinned = archivedChatIds.contains(a.id);
//   //     bool isBPinned = archivedChatIds.contains(b.id);

//   //     if (isAPinned && !isBPinned) {
//   //       return -1;
//   //     } else if (!isAPinned && isBPinned) {
//   //       return 1;
//   //     } else {
//   //       // For non-pinned items, you can use another criterion for sorting
//   //       return b.lastMessageTime!.compareTo(a.lastMessageTime ?? '');
//   //     }
//   //   });

//   //   for (var theId in archivedChatIds) {
//   //     chatModels.removeWhere((element) => element.id != theId);
//   //   }

//   //   print(chatModels);
//   //   yield chatModels;
//   // }

//   // static Stream<List<ChatModelDb>?> getAllUnreadUserChatsStream({
//   //   required String currentUserId,
//   //   required List<String> userChatIds,
//   // }) async* {
//   //   List<ChatModelDb>? chatModels = [];

//   //   for (var chatId in userChatIds) {
//   //     try {
//   //       final QuerySnapshot<Map<String, dynamic>> unreadMessagesQuery =
//   //           await firestore
//   //               .collection('chats')
//   //               .doc(chatId)
//   //               .collection('msglist')
//   //               .where('isRead', isEqualTo: false)
//   //               .where('receiverId', isEqualTo: currentUserId)
//   //               .limit(1)
//   //               .get();

//   //       // If there are unread messages, fetch the corresponding chat
//   //       if (unreadMessagesQuery.docs.isNotEmpty) {
//   //         final DocumentSnapshot userDoc =
//   //             await firestore.collection('chats').doc(chatId).get();

//   //         if (userDoc.exists) {
//   //           chatModels.add(
//   //             ChatModelDb.fromJson(userDoc.data() as Map<String, dynamic>),
//   //           );
//   //         } else {
//   //           yield null; // User not found
//   //         }
//   //       }
//   //     } catch (e) {
//   //       print('Error getting user by ID: $e');
//   //       yield null; // Handle error as needed
//   //     }
//   //   }

//   //   yield chatModels;
//   // }

//   static Stream<List<ChatModelDb>?> getAllUnreadUserChatsStream(
//       {required String currentUserId,
//       required List<String> userChatIds}) async* {
//     List<ChatModelDb>? chatModels = [];

//     // for (var chatId in userChatIds) {
//     //   try {
//     //     final QuerySnapshot<Map<String, dynamic>> unreadMessagesQuery =
//     //         await firestore
//     //             .collection('chats')
//     //             .doc(chatId)
//     //             .collection('msglist')
//     //             .where('isRead', isEqualTo: false)
//     //             .where(
//     //               'receiverId',
//     //               isEqualTo: currentUserId,
//     //             )
//     //             .get();

//     //     final QuerySnapshot<Map<String, dynamic>> unreadGroupMessagesQuery =
//     //         await firestore
//     //             .collection('chats')
//     //             .doc(chatId)
//     //             .collection('msglist')
//     //             .where('isRead', isEqualTo: false)
//     //             .where(
//     //               'receiversIds',
//     //               arrayContains: currentUserId,
//     //             )
//     //             .get();

//     //     // Merge both queries
//     //     final List<QueryDocumentSnapshot<Map<String, dynamic>>> mergedResults =
//     //         [...unreadMessagesQuery.docs, ...unreadGroupMessagesQuery.docs];

//     //     // If there are unread messages, fetch the corresponding chat
//     //     if (mergedResults.isNotEmpty) {
//     //       final DocumentSnapshot userDoc =
//     //           await firestore.collection('chats').doc(chatId).get();

//     //       if (userDoc.exists) {
//     //         chatModels.add(
//     //           ChatModelDb.fromJson(userDoc.data() as Map<String, dynamic>),
//     //         );
//     //       } else {
//     //         yield null; // User not found
//     //       }
//     //     }
//     //   } catch (e) {
//     //     print('Error getting user by ID: $e');
//     //     yield null; // Handle error as needed
//     //   }
//     // }

//     // yield chatModels;
//   }

//   static Stream<List<ChatMessageWithId>> getAllChatMessage(
//       {required String? chatId}) {
//     return firestore
//         .collection('chats/$chatId/msglist')
//         .orderBy('timestamp', descending: true) // Set descending to true
//         .snapshots()
//         .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
//       final messages =
//           snapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
//         print(doc.id);
//         return ChatMessageWithId(
//           id: doc.id,
//           message: ChatMessage.fromDocumentSnapshot(doc),
//         );
//       }).toList();
//       return messages;
//     });
//   }

//   static Future<String?> getMessageId({
//     required String? chatId,
//     required String? senderId,
//     required String? content,
//   }) async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('chats/$chatId/msglist')
//         .where('senderId', isEqualTo: senderId)
//         .where('content', isEqualTo: content)
//         .get();

//     // Check if any documents match the query
//     if (querySnapshot.docs.isNotEmpty) {
//       // Return the message ID of the first document found
//       return querySnapshot.docs[0].id;
//     } else {
//       // No matching document found
//       return null;
//     }
//   }

//   static Stream<DocumentSnapshot<Map<String, dynamic>>> getChatModelDB(
//       {required String? chatId}) {
//     return FirebaseFirestore.instance
//         .collection('chats')
//         .doc(chatId)
//         .snapshots()
//         .map((doc) => doc);
//   }

//   // static Stream<List<FireStoreUserModel>?> getAllUsersStream() async* {
//   //   List<FireStoreUserModel>? userModels = [];

//   //   try {
//   //     final QuerySnapshot usersSnapshot =
//   //         await firestore.collection('users').get();

//   //     for (var userDoc in usersSnapshot.docs) {
//   //       print(FireStoreUserModel.fromJson(
//   //           userDoc.data() as Map<String, dynamic>));
//   //       userModels.add(FireStoreUserModel.fromJson(
//   //           userDoc.data() as Map<String, dynamic>));
//   //     }
//   //   } catch (e) {
//   //     print('Error getting all users: $e');
//   //     yield null; // Handle error as needed
//   //   }

//   //   print(userModels);
//   //   yield userModels;
//   // }
//   static Future<List<FireStoreUserModel>?>? getAllUsers() async {
//     List<FireStoreUserModel>? userModels = [];

//     try {
//       final QuerySnapshot usersSnapshot =
//           await firestore.collection('users').get();

//       for (var userDoc in usersSnapshot.docs) {
//         print(FireStoreUserModel.fromJson(
//             userDoc.data() as Map<String, dynamic>));
//         userModels.add(FireStoreUserModel.fromJson(
//             userDoc.data() as Map<String, dynamic>));
//       }
//     } catch (e) {
//       print('Error getting all users: $e');
//       return null; // Handle error as needed
//     }

//     print(userModels);
//     return userModels;
//   }

//   static Future<List<FireStoreUserModel>?> getGroupUsers(String groupId) async {
//     try {
//       CollectionReference groupsCollection = firestore.collection('chats');
//       DocumentSnapshot groupSnapshot =
//           await groupsCollection.doc(groupId).get();

//       if (groupSnapshot.exists) {
//         List<String>? userIds = groupSnapshot['users']
//             .map<String>((user) => user['_id'] as String)
//             .toList();

//         CollectionReference usersCollection = firestore.collection('users');
//         List<FireStoreUserModel> groupUsers = [];

//         for (String userId in userIds ?? []) {
//           DocumentSnapshot userSnapshot =
//               await usersCollection.doc(userId).get();

//           if (userSnapshot.exists) {
//             groupUsers.add(FireStoreUserModel.fromJson(
//               userSnapshot.data() as Map<String, dynamic>,
//             ));
//           }
//         }

//         return groupUsers;
//       } else {
//         print('Group does not exist.');
//         return null;
//       }
//     } catch (e) {
//       print('Error getting group users: $e');
//       return null; // Handle error as needed
//     }
//   }

//   static Future<void> updateSessionId(
//       {required String? chatId, required String? sessionId}) async {
//     DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//     await chatRef.update({
//       'sessionID': sessionId,
//       'sessionExpiry': timeStampNow(),
//     });
//   }

//   static Future<void> updateGroupImage(
//       {required String? chatId, required String? groupImageLink}) async {
//     DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//     await chatRef.update({'groupImage': groupImageLink});
//   }

//   static Future<void> sendDirectMessage({
//     required ChatMessage chatMessage,
//     String? chatId,
//     FireStoreUserModel? senderFireStoreUserModel,
//     FireStoreUserModel? receiverFireStoreUserModel,
//   }) async {
//     try {
//       // Create a document reference for the chat document
//       DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//       print(chatRef);

//       chatRef.update({
//         'lastMessage': chatMessage.content,
//         'lastMessageTime': timeStampNow(),
//       });
//       // Create a map of the message object
//       Map<String, dynamic> messageData = chatMessage.toJson();
//       // Add the message to the chat document
//       print('TEST IF ENTER SEND MESSAGE');
//       await chatRef.collection('msglist').add(messageData);

//       if (!receiverFireStoreUserModel!.mutedIds!.contains(chatId)) {
//         await FireStoreAPIs.sendFCMRequest(
//             fcmToken: receiverFireStoreUserModel.fcmToken,
//             // 'cjrL7X8y1kYWi6kB3ikCOt:APA91bEImEflIn9MBE9jkoXW7Wc3nzBQ0lSxeysq-Zenlo6p3aDlb2Ywh7KJUoo6ZaK6FWKVfKhXaooL4igt4ZwbhLRiySDFEY3CHVNyXPDrXp3rA0KFMaDMMoJtGlVINNK7xlIf8_2J',
//             title:
//                 '${senderFireStoreUserModel?.firstName} ${senderFireStoreUserModel?.lastName}',
//             body: chatMessage.content);
//       }
//     } catch (error) {
//       print("Error sending message: $error");
//     }
//   }

//   static Stream<String?> getLastMessageContentStream(String chatId) async* {
//     try {
//       // Reference to the chat document
//       DocumentReference chatRef =
//           FirebaseFirestore.instance.collection('chats').doc(chatId);

//       // Listen for changes in the messages collection
//       await for (var _ in chatRef
//           .collection('msglist')
//           .orderBy('timestamp', descending: true)
//           .limit(1)
//           .snapshots()) {
//         String? lastMessageContent = await getLastMessageContent(chatId);
//         yield lastMessageContent;
//       }
//     } catch (error) {
//       print("Error getting last message content stream: $error");
//       yield null; // Handle error as needed
//     }
//   }

//   static Future<String?> getLastMessageContent(String chatId) async {
//     try {
//       // Reference to the chat document
//       DocumentReference chatRef =
//           FirebaseFirestore.instance.collection('chats').doc(chatId);

//       // Query the messages collection to get the last message content
//       QuerySnapshot<Map<String, dynamic>> messagesQuery = await chatRef
//           .collection('msglist')
//           .orderBy('timestamp', descending: true)
//           .limit(1)
//           .get();

//       // Check if there is a last message
//       if (messagesQuery.size > 0) {
//         return messagesQuery.docs[0]['content'];
//       }

//       return null; // Return null if there are no messages
//     } catch (error) {
//       print("Error getting last message content: $error");
//       return null; // Handle error as needed
//     }
//   }

//   static Future<void> markChatAsRead(
//       String chatId, String currentUserId) async {
//     try {
//       // Reference to the chat document
//       DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//       // Update the isRead field of messages intended for the current user to true
//       await chatRef
//           .collection('msglist')
//           .where('isRead', isEqualTo: false)
//           .where('receiverId', isEqualTo: currentUserId)
//           .get()
//           .then((querySnapshot) {
//         querySnapshot.docs.forEach((doc) {
//           doc.reference.update({'isRead': true});
//         });
//       });
//     } catch (error) {
//       print("Error marking chat as read: $error");
//     }
//   }

//   static Future<void> markGroupChatAsRead(
//       String chatId, String currentUserId) async {
//     try {
//       // Reference to the chat document
//       DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//       await chatRef
//           .collection('msglist')
//           .where('senderId', isNotEqualTo: currentUserId)
//           // .where('readByIds', arrayContains: currentUserId)
//           .get()
//           .then((querySnapshot) {
//         querySnapshot.docs.forEach((doc) async {
//           List<dynamic> readByIds = doc.data()['readByIds'] ?? [];
//           if (!readByIds.contains(currentUserId)) {
//             readByIds.add(currentUserId);
//             await doc.reference
//                 .update({'readByIds': readByIds, 'isRead': true});
//           }
//         });
//       });
//     } catch (error) {
//       print("Error marking chat as read: $error");
//     }
//   }

//   static Stream<int> getUnreadMessageCountStream(
//       {required String chatId, required String currentUserId}) async* {
//     try {
//       // Reference to the chat document
//       DocumentReference chatRef =
//           FirebaseFirestore.instance.collection('chats').doc(chatId);

//       // Listen for changes in the messages collection
//       await for (var _ in chatRef
//           .collection('msglist')
//           .where('isRead', isEqualTo: false)
//           .where('receiverId', isEqualTo: currentUserId)
//           .snapshots()) {
//         int count = await getUnreadMessageCount(
//             chatId: chatId, currentUserId: currentUserId);

//         yield count;
//       }
//     } catch (error) {
//       print("Error getting unread message count: $error");
//       yield 0; // Return 0 in case of an error
//     }
//   }

//   static Future<int> getUnreadMessageCount({
//     required String chatId,
//     required String currentUserId,
//   }) async {
//     try {
//       // Reference to the chat document
//       DocumentReference chatRef =
//           FirebaseFirestore.instance.collection('chats').doc(chatId);

//       // Query the messages collection to count unread messages
//       QuerySnapshot<Map<String, dynamic>> messagesQuery = await chatRef
//           .collection('msglist')
//           .where('isRead', isEqualTo: false)
//           .where('receiverId', isEqualTo: currentUserId)
//           .get();

//       // Return the count of unread messages
//       return messagesQuery.size;
//     } catch (error) {
//       print("Error getting unread message count: $error");
//       return 0; // Return 0 in case of an error
//     }
//   }

//   static Stream<int> getUnreadGroupMessageCountStream({
//     required String chatId,
//     required String currentUserId,
//   }) async* {
//     try {
//       // Reference to the chat document
//       DocumentReference chatRef =
//           FirebaseFirestore.instance.collection('chats').doc(chatId);

//       // Listen for changes in the messages collection
//       await for (var _ in chatRef
//           .collection('msglist')
//           .where('isRead', isEqualTo: false)
//           .where('receiversIds', arrayContains: currentUserId)
//           .snapshots()) {
//         int count = await getUnreadGroupMessageCount(
//             chatId: chatId, currentUserId: currentUserId);

//         yield count;
//       }
//     } catch (error) {
//       print("Error getting unread group message count: $error");
//       yield 0; // Return 0 in case of an error
//     }
//   }

//   static Future<int> getUnreadGroupMessageCount({
//     required String chatId,
//     required String currentUserId,
//   }) async {
//     try {
//       // Reference to the chat document
//       DocumentReference chatRef =
//           FirebaseFirestore.instance.collection('chats').doc(chatId);

//       // Query the messages collection to count unread messages
//       QuerySnapshot<Map<String, dynamic>> messagesQuery = await chatRef
//           .collection('msglist')
//           .where('isRead', isEqualTo: false)
//           .where('receiversIds', arrayContains: currentUserId)
//           .get();

//       // Return the count of unread messages
//       return messagesQuery.size;
//     } catch (error) {
//       print("Error getting unread group message count: $error");
//       return 0; // Return 0 in case of an error
//     }
//   }

// //   static Future<void> markChatAsRead(String chatId) async {
// //     try {
// //       // Reference to the chat document
// //       DocumentReference chatRef = firestore.collection('chats').doc(chatId);

// //       // Update the isRead field of all messages to true
// //       await chatRef
// //           .collection('msglist')
// //           .where('isRead', isEqualTo: false)
// //           .get()
// //           .then((querySnapshot) {
// //         querySnapshot.docs.forEach((doc) {
// //           doc.reference.update({'isRead': true});
// //         });
// //       });
// //     } catch (error) {
// //       print("Error marking chat as read: $error");
// //     }
// //   }

// //   static Future<int> getUnreadMessageCount(String chatId) async {
// //   try {
// //     // Reference to the chat document
// //     DocumentReference chatRef = FirebaseFirestore.instance.collection('chats').doc(chatId);

// //     // Query the messages collection to count unread messages
// //     QuerySnapshot<Map<String, dynamic>> messagesQuery = await chatRef
// //         .collection('msglist')
// //         .where('isRead', isEqualTo: false)
// //         .get();

// //     // Return the count of unread messages
// //     return messagesQuery.size;
// //   } catch (error) {
// //     print("Error getting unread message count: $error");
// //     return 0; // Return 0 in case of an error
// //   }
// // }

//   // static Stream<List<ChatMessage>?> getAllChatMessage(
//   //     {required String chatId}) async* {
//   //   List<ChatMessage>? chatMessages = [];

//   //   try {
//   //     final QuerySnapshot<Map<String, dynamic>> chatDocs = await firestore
//   //         .collection('chats')
//   //         .where('id', isEqualTo: chatId)
//   //         .get();

//   //     print(chatDocs);

//   //     if (chatDocs.docs.isNotEmpty) {
//   //       for (var doc in chatDocs.docs) {
//   //         QuerySnapshot<Map<String, dynamic>> messagesSnapshot = await doc
//   //             .reference
//   //             .collection('msglist')
//   //             // .orderBy(
//   //             //     'timestamp') // You may need to adjust the ordering based on your requirements
//   //             .get();

//   //         if (messagesSnapshot.docs.isNotEmpty) {
//   //           // Convert each message document to a ChatMessage object
//   //           chatMessages.addAll(messagesSnapshot.docs.map(
//   //             (messageDoc) => ChatMessage.fromJson(
//   //                 messageDoc.data() as Map<String, dynamic>),
//   //           ));
//   //         }
//   //       }
//   //     } else {
//   //       yield null;
//   //     }
//   //   } catch (e) {
//   //     print('Error getting chat messages: $e');
//   //     yield null;
//   //   }

//   //   print(chatMessages);
//   //   yield chatMessages;
//   // }

//   // static Stream<List<ChatMessage>?> getAllChatMessage(
//   //     {required String chatId}) {
//   //   try {
//   //     final CollectionReference chatCollection = firestore.collection('chats');

//   //     return chatCollection
//   //         .where('id', isEqualTo: chatId)
//   //         .snapshots()
//   //         .asyncMap<List<ChatMessage>?>((chatDocs) async {
//   //       List<ChatMessage>? chatMessages = [];

//   //       if (chatDocs.docs.isNotEmpty) {
//   //         for (var doc in chatDocs.docs) {
//   //           QuerySnapshot<Map<String, dynamic>> messagesSnapshot =
//   //               await doc.reference
//   //                   .collection('msglist')
//   //                   // .orderBy('timestamp')
//   //                   .get();

//   //           if (messagesSnapshot.docs.isNotEmpty) {
//   //             // Convert each message document to a ChatMessage object
//   //             chatMessages.addAll(messagesSnapshot.docs.map(
//   //               (messageDoc) => ChatMessage.fromJson(
//   //                   messageDoc.data() as Map<String, dynamic>),
//   //             ));
//   //           }
//   //         }
//   //       } else {
//   //         return null;
//   //       }

//   //       return chatMessages;
//   //     }).handleError((error) {
//   //       print('Error getting chat messages: $error');
//   //       return null;
//   //     });
//   //   } catch (e) {
//   //     print('Error: $e');
//   //     return Stream.value(null);
//   //   }
//   // }

//   // static createUser({required LoginResponse loginResponse}) async {
//   //   FireStoreUserModel fireStoreUserModel = FireStoreUserModel(
//   //     createdAt: loginResponse.data?.createdAt,
//   //     deleted: loginResponse.data?.deleted,
//   //     email: loginResponse.data?.email,
//   //     emailVerified: loginResponse.data?.emailVerified,
//   //     firstName: loginResponse.data?.firstName,
//   //     lastName: loginResponse.data?.lastName,
//   //     id: loginResponse.data?.id,
//   //     password: loginResponse.data?.password,
//   //     phone: loginResponse.data?.phone,
//   //     phoneVerified: loginResponse.data?.phoneVerified,
//   //     token: loginResponse.token,
//   //     updatedAt: loginResponse.data?.updatedAt,
//   //     username: loginResponse.data?.username,
//   //     searchWord:
//   //         '${loginResponse.data?.firstName?.toLowerCase()} ${loginResponse.data?.lastName?.toLowerCase()}',
//   //     fcmToken: GlobalFunctions.hiveGet(GlobalHiveKeys.messagingToken),
//   //     chatIds: [],
//   //     pinnedChatIds: [],
//   //     directChatMails: [],
//   //   );

//   //   print(fireStoreUserModel);

//   //   firestore
//   //       .collection('users')
//   //       .doc(fireStoreUserModel.id)
//   //       .set(fireStoreUserModel.toJson());
//   // }
//   static createUser({required LoginResponse loginResponse}) async {
//     FireStoreUserModel fireStoreUserModel = FireStoreUserModel(
//         createdAt: loginResponse.userData?.createdAt,
//         deleted: loginResponse.userData?.deleted,
//         email: loginResponse.userData?.email,
//         emailVerified: loginResponse.userData?.emailVerified,
//         firstName: loginResponse.userData?.firstName,
//         lastName: loginResponse.userData?.lastName,
//         id: loginResponse.userData?.id,
//         password: loginResponse.userData?.password,
//         phone: loginResponse.userData?.phone,
//         phoneVerified: loginResponse.userData?.phoneVerified,
//         token: loginResponse.token,
//         updatedAt: loginResponse.userData?.updatedAt,
//         username: loginResponse.userData?.username,
//         searchWord:
//             '${loginResponse.userData?.firstName?.toLowerCase()} ${loginResponse.userData?.lastName?.toLowerCase()}',
//         fcmToken: GlobalFunctions.hiveGet(GlobalHiveKeys.messagingToken),
//         chatIds: [],
//         pinnedChatIds: [],
//         directChatMails: [],
//         archivedChatIds: [],
//         mutedIds: [],
//         topicsToSubscribe: []);

//     print(fireStoreUserModel);

//     // Reference to the user document
//     final userDocRef = firestore.collection('users').doc(fireStoreUserModel.id);

//     // Check if the document exists
//     final docSnapshot = await userDocRef.get();

//     if (!docSnapshot.exists) {
//       // Document doesn't exist, create it with the provided data
//       userDocRef.set(fireStoreUserModel.toJson());
//     } else {
//       // Document already exists, update only specific fields
//       userDocRef.set(
//         {
//           'fcmToken': GlobalFunctions.hiveGet(GlobalHiveKeys.messagingToken),
//           'email': fireStoreUserModel.email,
//           'emailVerified': fireStoreUserModel.emailVerified,
//           '_id': fireStoreUserModel.id,
//           'created_at': fireStoreUserModel.createdAt,
//           'deleted': fireStoreUserModel.deleted,
//           'firstName': fireStoreUserModel.firstName,
//           'lastName': fireStoreUserModel.lastName,
//           'password': fireStoreUserModel.password,
//           'phone': fireStoreUserModel.phone,
//           'phoneVerified': fireStoreUserModel.phoneVerified,
//           'searchWord':
//               '${fireStoreUserModel.firstName?.toLowerCase()} ${fireStoreUserModel.lastName?.toLowerCase()}',
//         },
//         SetOptions(merge: true),
//       );
//     }
//   }

//   // static Future<bool> createGroup({required ChatModelDb chatModelDb}) async {
//   //   try {
//   //     CollectionReference groupsCollection = firestore.collection('chats');

//   //     List<Map<String, dynamic>>? userchattListt =
//   //         chatModelDb.users?.map((user) => user.toMap()).toList();

//   //     DocumentReference groupDocRef = await groupsCollection.add({
//   //       'label': chatModelDb.label,
//   //       'users': userchattListt,
//   //       'type': chatModelDb.type,
//   //       'messages': [],
//   //       'eventsSummary': [],
//   //     });
//   //     await groupDocRef.update({'id': groupDocRef.id});

//   //     return true; // Operation was successful
//   //   } catch (e) {
//   //     print('Error creating group: $e');
//   //     return false; // Operation failed
//   //   }
//   // }

//   static Future<bool> pinUnPinChat(
//       {required String userId,
//       required List<String> updatedListOfStrings}) async {
//     try {
//       CollectionReference usersCollection = firestore.collection('users');
//       DocumentReference userDocRef = usersCollection.doc(userId);

//       await userDocRef.update({
//         'pinnedChatIds': updatedListOfStrings,
//       });

//       print('Chat pinned status and pinned chatIds updated successfully!');
//       return true; // Operation was successful
//     } catch (e) {
//       print('Error updating chat pinned status and pinned chatIds: $e');
//       return false; // Operation failed
//     }
//   }

//   static Future<void> clearTopics({required String userId}) async {
//     try {
//       FireStoreUserModel? fireStoreUserModel =
//           await getUserById(userId: userId);

//       if (fireStoreUserModel!.topicsToSubscribe!.isNotEmpty) {
//         for (var element in fireStoreUserModel.topicsToSubscribe!) {
//           FireStoreAPIs.subscribeToTopic(topicName: element);
//         }
//       }
//       CollectionReference usersCollection = firestore.collection('users');
//       DocumentReference userDocRef = usersCollection.doc(userId);

//       await userDocRef.update({
//         'topicsToSubscribe': [],
//       });
//     } catch (e) {
//       print('Error updating chat pinned status and pinned chatIds: $e');
//     }
//   }

//   static Future<bool> archiveUnArchiveChat(
//       {required String userId,
//       required List<String> updatedListOfStrings}) async {
//     try {
//       CollectionReference usersCollection = firestore.collection('users');
//       DocumentReference userDocRef = usersCollection.doc(userId);

//       await userDocRef.update({'archivedChatIds': updatedListOfStrings});

//       print('Chat pinned status and pinned chatIds updated successfully!');
//       return true; // Operation was successful
//     } catch (e) {
//       print('Error updating chat pinned status and pinned chatIds: $e');
//       return false; // Operation failed
//     }
//   }

//   static Future<bool> muteUnmuteChat(
//       {required String userId,
//       required List<String> updatedListOfStrings}) async {
//     try {
//       CollectionReference usersCollection = firestore.collection('users');
//       DocumentReference userDocRef = usersCollection.doc(userId);

//       await userDocRef.update({'mutedIds': updatedListOfStrings});

//       print('Chat muted successfully!');
//       return true; // Operation was successful
//     } catch (e) {
//       print('Error muting: $e');
//       return false; // Operation failed
//     }
//   }

//   static Future<bool> createGroup(
//       {required ChatModelDb chatModelDb,
//       required List<String>? userIds,
//       required String? currentUserId,
//       required List<String>? allUsers}) async {
//     try {
//       CollectionReference groupsCollection = firestore.collection('chats');

//       // Create the group chat
//       List<Map<String, dynamic>>? userChatList =
//           chatModelDb.users?.map((user) => user.toMap()).toList();

//       print(userChatList);

//       Map<String, int> map = {};
//       for (String str in allUsers ?? []) {
//         map[str] = 0;
//       }
//       // any update
//       DocumentReference groupDocRef = await groupsCollection.add({
//         'label': chatModelDb.label,
//         'users': userChatList,
//         'type': chatModelDb.type,
//         'messages': [],
//         'eventsSummary': [],
//         'countJsonEncoded': map,
//         'lastMessageTime': timeStampNow(),
//         'groupImage': chatModelDb.groupImage,
//         'pinned': false,
//         'userIds': allUsers,
//       });

//       await groupDocRef.update({'id': groupDocRef.id});

//       if (userIds != null) {
//         CollectionReference usersCollection = firestore.collection('users');

//         for (String userId in userIds) {
//           DocumentReference userDocRef = usersCollection.doc(userId);

//           List<String>? topicToSubscibeTo = await userDocRef.get().then((doc) {
//             if (doc.exists) {
//               return List<String>.from(doc['topicsToSubscribe'] ?? []);
//             }
//             return null;
//           });
//           List<String>? currentChatroomIds = await userDocRef.get().then((doc) {
//             if (doc.exists) {
//               return List<String>.from(doc['chatIds'] ?? []);
//             }
//             return null;
//           });

//           if (currentChatroomIds != null) {
//             currentChatroomIds.add(groupDocRef.id);

//             await userDocRef.update({
//               'chatIds': currentChatroomIds,
//             });
//           } else if (currentChatroomIds == null) {
//             await userDocRef.set({
//               'chatIds': [groupDocRef.id],
//             }, SetOptions(merge: true));
//           }

//           if (topicToSubscibeTo != null) {
//             topicToSubscibeTo.add(groupDocRef.id);

//             await userDocRef.update({'topicsToSubscribe': topicToSubscibeTo});
//           } else if (topicToSubscibeTo == null) {
//             await userDocRef.set({
//               'chatIds': [groupDocRef.id],
//               'topicsToSubscribe': [groupDocRef.id],
//             }, SetOptions(merge: true));
//           }
//         }
//       }

//       CollectionReference usersCollection = firestore.collection('users');

//       DocumentReference userDocRef = usersCollection.doc(currentUserId);

//       List<String>? currentChatroomIds = await userDocRef.get().then((doc) {
//         if (doc.exists) {
//           return List<String>.from(doc['chatIds'] ?? []);
//         }
//         return null;
//       });
//       List<String>? topicsToSubscribe = await userDocRef.get().then((doc) {
//         if (doc.exists) {
//           return List<String>.from(doc['topicsToSubscribe'] ?? []);
//         }
//         return null;
//       });

//       if (currentChatroomIds != null) {
//         currentChatroomIds.add(groupDocRef.id);
//         topicsToSubscribe?.add(groupDocRef.id);

//         await userDocRef.update({
//           'chatIds': currentChatroomIds,
//           'topicsToSubscribe': topicsToSubscribe
//         });
//       } else if (currentChatroomIds == null) {
//         await userDocRef.set({
//           'chatIds': [groupDocRef.id],
//           'topicsToSubscribe': [groupDocRef.id],
//         }, SetOptions(merge: true));
//       }

//       return true; // Operation was successful
//     } catch (e) {
//       print('Error creating group: $e');
//       return false; // Operation failed
//     }
//   }

//   static Future<bool> addUserToGroup({
//     required String groupId,
//     required List<String>? userIds,
//   }) async {
//     try {
//       if (userIds == null || userIds.isEmpty) {
//         // Handle the case where userIds is null or empty
//         print('Error: userIds is null or empty');
//         return false; // Operation failed
//       }

//       CollectionReference groupsCollection = firestore.collection('chats');
//       DocumentReference groupDocRef = groupsCollection.doc(groupId);

//       print(groupDocRef);

//       // Fetch the current users in the group
//       List<Map<String, dynamic>>? currentUsers =
//           await groupDocRef.get().then((doc) {
//         if (doc.exists) {
//           return List<Map<String, dynamic>>.from(doc['users'] ?? []);
//         }
//         return null;
//       });

//       List<String>? userIDS = await groupDocRef.get().then((doc) {
//         if (doc.exists) {
//           return List<String>.from(doc['userIds'] ?? []);
//         }
//         return null;
//       });

//       for (var id in userIds) {
//         if (!userIDS!.contains(id)) {
//           userIDS.add(id);
//         }
//       }

//       print(groupDocRef.get().then((doc) {
//         print(doc);
//         print(doc['countJsonEncoded']);
//       }));

//       groupDocRef.update({'userIds': userIDS});

//       if (currentUsers != null) {
//         // Add new users to the existing users list
//         for (String userId in userIds) {
//           if (userId.isNotEmpty) {
//             // Check if the user is not already in the group
//             bool userExists = currentUsers.any((user) => user['_id'] == userId);

//             if (!userExists) {
//               // Fetch user details and add to the group's users list
//               DocumentReference userDocRef =
//                   firestore.collection('users').doc(userId);
//               Map<String, dynamic>? userData =
//                   await userDocRef.get().then((doc) {
//                 if (doc.exists) {
//                   return doc.data() as Map<String, dynamic>;
//                 }
//                 return null;
//               });

//               if (userData != null) {
//                 currentUsers.add(userData);

//                 // Update the user with the groupId in their chatIds
//                 List<String>? chatIds =
//                     List<String>.from(userData['chatIds'] ?? []);
//                 chatIds.add(groupId);

//                 await userDocRef.update({'chatIds': chatIds});
//               }
//             }
//           }
//         }

//         // Update the group with the new users list
//         await groupDocRef.update({
//           'users': currentUsers,
//         });

//         return true; // Operation was successful
//       } else {
//         print('Error fetching group details');
//         return false; // Operation failed
//       }
//     } catch (e) {
//       print('Error adding users to group: $e');
//       return false; // Operation failed
//     }
//   }

//   static Future<bool> leaveGroup({
//     required String groupId,
//     required String userId,
//   }) async {
//     try {
//       // Fetch the group document reference
//       DocumentReference groupDocRef =
//           firestore.collection('chats').doc(groupId);

//       List<String>? userIds = await groupDocRef.get().then((doc) {
//         if (doc.exists) {
//           return List<String>.from(doc['userIds'] ?? []);
//         }
//         return null;
//       });

//       // Fetch the current users in the group
//       List<Map<String, dynamic>>? currentUsers =
//           await groupDocRef.get().then((doc) {
//         if (doc.exists) {
//           return List<Map<String, dynamic>>.from(doc['users'] ?? []);
//         }
//         return null;
//       });

//       userIds?.removeWhere((user) => user == userId);
//       if (currentUsers != null) {
//         // Remove the user from the group's users list
//         currentUsers.removeWhere((user) => user['_id'] == userId);

//         // Update the group with the new users list
//         await groupDocRef.update({
//           'users': currentUsers,
//           'userIds': userIds,
//         });

//         // Fetch user document reference
//         DocumentReference userDocRef =
//             firestore.collection('users').doc(userId);

//         // Fetch user's current chatIds
//         List<String>? currentChatroomIds = await userDocRef.get().then((doc) {
//           if (doc.exists) {
//             return List<String>.from(doc['chatIds'] ?? []);
//           }
//           return null;
//         });

//         if (currentChatroomIds != null) {
//           // Remove the groupId from user's chatIds
//           currentChatroomIds.remove(groupId);

//           // Update the user with the new chatIds
//           await userDocRef.update({
//             'chatIds': currentChatroomIds,
//           });
//         }

//         return true; // Operation was successful
//       } else {
//         print('Error fetching group details');
//         return false; // Operation failed
//       }
//     } catch (e) {
//       print('Error leaving group: $e');
//       return false; // Operation failed
//     }
//   }

//   static Future<void> sendMessage({
//     required ChatMessage chatMessage,
//     String? chatId,
//     FireStoreUserModel? senderFireStoreUserModel,
//     FireStoreUserModel? receiverFireStoreUserModel,
//   }) async {
//     try {
//       // Create a document reference for the chat document
//       DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//       print(chatRef);

//       chatRef.update({
//         'lastMessage': chatMessage.content,
//         'lastMessageTime': timeStampNow()
//       });
//       // Create a map of the message object
//       Map<String, dynamic> messageData = chatMessage.toJson();
//       // Add the message to the chat document
//       print('TEST IF ENTER SEND MESSAGE');
//       await chatRef.collection('msglist').add(messageData);

//       if (receiverFireStoreUserModel!.mutedIds!.contains(chatId)) {
//         print('MUTTTTTTTTTEEEE');
//       } else {
//         print('NOTTT MUTTTTTTTTTEEEE');
//         await FireStoreAPIs.sendFCMRequest(
//             fcmToken: receiverFireStoreUserModel.fcmToken,
//             title:
//                 '${senderFireStoreUserModel?.firstName} ${senderFireStoreUserModel?.lastName}',
//             body: chatMessage.content);
//       }
//     } catch (error) {
//       print("Error sending message: $error");
//     }
//   }

//   // static Future<void> sendGroupMessage(
//   //     {required BuildContext context,
//   //     required ChatMessage chatMessage,
//   //     String? chatId,
//   //     required String? groupName,
//   //     List<FireStoreUserModel>? listFireStoreUser,
//   //     required FireStoreUserModel senderFireStoreUserModel,
//   //     required String? currentFCMToken,
//   //     required ChatModelDb? chatModelDb}) async {
//   //   // try {
//   //   // Create a document reference for the chat document
//   //   DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//   //   chatRef.collection('msglist').get().then((querySnapshot) {
//   //     List<ChatMessage> messages = querySnapshot.docs.map((doc) {
//   //       return ChatMessage.fromDocumentSnapshot(doc);
//   //     }).toList();

//   //     List<String> receivers =
//   //         listFireStoreUser?.map((e) => e.id ?? '').toList() ?? [];
//   //     receivers.add(senderFireStoreUserModel.id ?? '');

//   //     saveNumberOFUnread(
//   //         chatModelDb: chatModelDb!,
//   //         ids: receivers,
//   //         context: context,
//   //         chatMessages: messages);

//   //     // Now 'messages' list contains all messages from the collection
//   //     print(messages);
//   //   }).catchError((error) {
//   //     print("Error getting documents: $error");
//   //   });
//   // }

//   static String senderFullName(
//       {required ChatModelDb chatModelDb, required ChatMessage chatMessage}) {
//     for (var user in chatModelDb.users!) {
//       if (chatMessage.senderId == user.id) {
//         return '${user.firstName} ${user.lastName}';
//       }
//     }
//     return '';
//   }

//   // static void updateMyFcmToken(
//   //     {required List<String> chatIdsToUpdateTheDifferentFcmTokens,
//   //     required FireStoreUserModel? currentFireStoreUserModel}) async {
//   //   print(chatIdsToUpdateTheDifferentFcmTokens);

//   //   for (var elment in chatIdsToUpdateTheDifferentFcmTokens) {
//   //     DocumentReference chatRef = firestore.collection('chats').doc(elment);

//   //     ChatModelDb? chatModelById = await getChatModelById(chatId: elment);
//   //     List<FireStoreUserModel>? otherUserThanTheCurrent = chatModelById?.users
//   //         ?.where((element) => element.id != currentFireStoreUserModel?.id)
//   //         .toList();

//   //     // FireStoreUserModel? currentUser = chatModelById?.users
//   //     //     ?.where((element) => element.id == currentFireStoreUserModel?.id)
//   //     //     .first;

//   //     // currentUser?.fcmToken = currentFCMTOKEN;

//   //     otherUserThanTheCurrent?.add(currentFireStoreUserModel!);
//   //     print(chatModelById?.users
//   //         ?.where((element) => element.id == currentFireStoreUserModel?.id)
//   //         .first);

//   //     chatRef.update({'users': otherUserThanTheCurrent});
//   //   }
//   // }

//   static void updateMyFcmToken({
//     required List<String> chatIdsToUpdateTheDifferentFcmTokens,
//     required FireStoreUserModel? currentFireStoreUserModel,
//   }) async {
//     print(chatIdsToUpdateTheDifferentFcmTokens);

//     // Serialize the current user model to a Map
//     Map<String, dynamic> userData = currentFireStoreUserModel?.toJson() ?? {};

//     for (var chatId in chatIdsToUpdateTheDifferentFcmTokens) {
//       DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//       ChatModelDb? chatModel = await getChatModelById(chatId: chatId);

//       if (chatModel != null) {
//         // Get other users in the chat
//         List<Map<String, dynamic>> otherUsers = chatModel.users!
//             .where((user) => user.id != currentFireStoreUserModel?.id)
//             .map((user) => user.toJson())
//             .toList();

//         // Add current user's data to the list of other users
//         otherUsers.add(userData);

//         // Update the chat document with the updated list of users
//         chatRef.update({'users': otherUsers});
//       }
//     }
//   }

//   static Future<void> sendGroupMessage({
//     required BuildContext context,
//     required ChatMessage chatMessage,
//     String? chatId,
//     required String? groupName,
//     List<FireStoreUserModel>? listFireStoreUser,
//     required FireStoreUserModel senderFireStoreUserModel,
//     required String? currentFCMToken,
//     required ChatModelDb? chatModelDb,
//   }) async {
//     try {
//       // Create a document reference for the chat document
//       DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//       print(chatRef);

//       String? senderName =
//           '${senderFireStoreUserModel.firstName} ${senderFireStoreUserModel.lastName}';

//       chatRef.update({
//         'lastMessage': chatMessage.type == 'gif'
//             ? '$senderName GIF'
//             : chatMessage.type == 'audio'
//                 ? '$senderName Audio ♫'
//                 : chatMessage.type == 'card'
//                     ? 'Fluid Card'
//                     : chatMessage.type == 'image'
//                         ? '$senderName Image'
//                         : chatMessage.content,
//         'lastMessageTime': timeStampNow()
//       });
//       // Create a map of the message object
//       Map<String, dynamic> messageData = chatMessage.toJson();

//       // Add the message to the chat document
//       await chatRef.collection('msglist').add(messageData);

//       chatRef.collection('msglist').get().then((querySnapshot) {
//         List<ChatMessage> messages = querySnapshot.docs.map((doc) {
//           return ChatMessage.fromDocumentSnapshot(doc);
//         }).toList();

//         List<String> receivers =
//             listFireStoreUser?.map((e) => e.id ?? '').toList() ?? [];
//         receivers.add(senderFireStoreUserModel.id ?? '');

//         saveNumberOFUnread(
//           chatModelDb: chatModelDb!,
//           ids: receivers,
//           context: context,
//         );

//         // Now 'messages' list contains all messages from the collection
//         print(messages);
//       }).catchError((error) {
//         print("Error getting documents: $error");
//       });

//       // List<String> userIds = listFireStoreUser?.map((e) => e.id ?? '').toList() ?? [];

//       // for (var element in userIds) {
//       // }
//       //       getUserById(userId: userId)
//       // for (var user in listFireStoreUser!) {
//       //   await FireStoreAPIs.sendFCMRequest(
//       //       fcmToken: user.fcmToken,
//       //       // 'cjrL7X8y1kYWi6kB3ikCOt:APA91bEImEflIn9MBE9jkoXW7Wc3nzBQ0lSxeysq-Zenlo6p3aDlb2Ywh7KJUoo6ZaK6FWKVfKhXaooL4igt4ZwbhLRiySDFEY3CHVNyXPDrXp3rA0KFMaDMMoJtGlVINNK7xlIf8_2J',
//       //       title:
//       //           '${senderFireStoreUserModel.firstName} ${senderFireStoreUserModel.lastName}',
//       //       body: chatMessage.content);
//       // }

//       await sendFCMRequestToTopic(
//           chatId: chatId,
//           groupName: groupName,
//           type: chatMessage.type,
//           message: chatMessage.content,
//           currentFCMToken: currentFCMToken,
//           listFireStoreUser: listFireStoreUser,
//           chatModelDb: chatModelDb);
//     } catch (error) {
//       print("Error sending message: $error");
//     }
//   }

//   static Future<String> startChat(
//       {ChatModelDb? chatModelDb,
//       required String? message,
//       required MessagesTypes? type,
//       required FireStoreUserModel? sender,
//       required FireStoreUserModel? receiver}) async {
//     print(sender);
//     print(receiver);
//     // Create a document reference for the chat document with a temporary ID
//     DocumentReference chatRef = firestore.collection('chats').doc();

//     print(chatRef);

//     // Create a message object
//     ChatMessage chatMessage = ChatMessage(
//       content: message,
//       isRead: false,
//       response: '',
//       isSent: true,
//       senderId: sender?.id,
//       receiverId: receiver?.id,
//       replyMessage: null,
//       // to be fixed later here
//       type: type == MessagesTypes.text
//           ? 'text'
//           : type == MessagesTypes.image
//               ? 'image'
//               : 'other',
//     );

//     // Create a map of the message object
//     Map<String, dynamic> messageData = chatMessage.toJson();

//     // Add the message to the chat document
//     await chatRef.collection('msglist').add(messageData);

//     FireStoreUserModel? senderr = sender;
//     FireStoreUserModel? receiverr = receiver;

//     List<String> userIdss = [senderr?.id ?? '', receiverr?.id ?? ''];

//     // UsersChat senderr = UsersChat(userId: sender?.id, email: sender?.email);
//     // UsersChat receiverr =
//     //     UsersChat(userId: receiver?.id, email: receiver?.email);

//     // Update the chat document with the final ID and other fields
//     await chatRef.set({
//       'id': chatRef.id, // Set the document ID as the final ID
//       // 'messages': FieldValue.arrayUnion([chatMessage.toJson()]),
//       'type': 'direct', // Set other fields as needed
//       'pinned': false,
//       'lastMessage': message,
//       'lastMessageTime': timeStampNow(),
//       'users': FieldValue.arrayUnion([senderr?.toJson(), receiverr?.toJson()]),
//       'userIds': userIdss,
//     });

//     DocumentReference senderDocRef =
//         firestore.collection('users').doc(sender?.id);
//     DocumentReference receiverDocRef =
//         firestore.collection('users').doc(receiver?.id);

//     senderDocRef.update({
//       'directChatMails': FieldValue.arrayUnion([receiver?.email]),
//       'chatIds': FieldValue.arrayUnion([chatRef.id]),
//     });
//     receiverDocRef.update({
//       'directChatMails': FieldValue.arrayUnion([sender?.email]),
//       'chatIds': FieldValue.arrayUnion([chatRef.id]),
//     });

//     sendFCMRequest(
//         fcmToken: receiver?.fcmToken,
//         firstName: sender?.firstName,
//         lastName: sender?.lastName,
//         body: message,
//         title: '${sender?.firstName} ${sender?.lastName}');
//     return chatRef.id;
//   }

//   static Future<void> createFcmToken() async {
//     // if (GlobalFunctions.hiveGet(GlobalHiveKeys.messagingToken) != null) {}
//     final fcmToken = await FirebaseMessaging.instance.getToken();
//     GlobalFunctions.hivePut(GlobalHiveKeys.messagingToken, fcmToken);
//     print(GlobalFunctions.hiveGet(GlobalHiveKeys.messagingToken));
//     print('Messaging Token: $fcmToken');

//     FireStoreFunctions.requestNotificationPermission();
//   }

//   static Future<void> logout() async {
//     // if (GlobalFunctions.hiveGet(GlobalHiveKeys.messagingToken) != null) {}
//     await FirebaseMessaging.instance.deleteToken();
//     await OneSignal.shared.clearOneSignalNotifications();
//   }

//   static Future<void> sendFCMRequest({
//     String? fcmToken,
//     String? title,
//     String? body,
//     String? chatId,
//     String? firstName,
//     String? lastName,
//   }) async {
//     String fcmUrl = "https://fcm.googleapis.com/fcm/send";
//     final Map<String, dynamic> requestBody = {
//       "to": fcmToken,
//       "notification": {
//         "title": title,
//         "body": body,
//         "sound": "default",
//         "data": {
//           // "click_action": "FLUTTER_NOTIFICATION_CLICK",
//           // "status": "done",
//           // "screen": "/userchatScreen",
//           // "chatId": chatId,
//           // "fromFname": firstName,
//           // "fromLname": lastName
//         }
//       }
//     };

//     final http.Response response = await http.post(
//       Uri.parse(fcmUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$messagingKey'
//       },
//       body: jsonEncode(requestBody),
//     );

//     if (response.statusCode == 200) {
//       print('FCM request sent successfully');
//       print('Response body: ${response.body}');
//     } else {
//       print('Failed to send FCM request. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   }

//   static Future<void> sendFCMRequestToTopic(
//       {required String? chatId,
//       required String? groupName,
//       required String? type,
//       required String? message,
//       required String? currentFCMToken,
//       required List<FireStoreUserModel>? listFireStoreUser,
//       required ChatModelDb? chatModelDb}) async {
//     String fcmUrl = "https://fcm.googleapis.com/fcm/send";

//     ChatModelDb? chatModelById = await getChatModelById(chatId: chatId ?? '');
//     print(chatModelById?.users);

//     List<String?>? tokenIdss = [];
//     for (var userInFireStore in listFireStoreUser!) {
//       await getUserById(userId: userInFireStore.id ?? '').then((value) {
//         print(value);
//         print(userInFireStore.mutedIds!.contains(chatId));
//         if (!value!.mutedIds!.contains(chatId)) {
//           tokenIdss.add(userInFireStore.fcmToken);
//         }
//       });
//     }

//     print('TOKENS ${tokenIdss.length} $tokenIdss');

//     // chatModelById?.users?.map((e) => e.fcmToken).toList();
//     // tokenIdss.removeWhere((element) => element == currentFCMToken);

//     print(tokenIdss);

//     final Map<String, dynamic> requestBody = {
//       // "to": "/topics/$chatId",
//       "notification": {
//         "title": groupName,
//         if (type != 'image') "body": message,
//         "sound": "default",
//         if (type == 'image') "image": message,
//       },
//       "data": {
//         if (type == 'image') "imageUrl": message,
//         // "click_action": "FLUTTER_NOTIFICATION_CLICK",
//         "chatModelDb": jsonEncode(chatModelDb?.toJson()),
//         "screen": "/groupchatDetailsScreen",
//         // "chatId": chatId,
//         // "fromFname": firstName,
//         // "fromLname": lastName
//       },
//       "registration_ids": tokenIdss
//     };

//     final http.Response response = await http.post(Uri.parse(fcmUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$messagingKey'
//         },
//         body: jsonEncode(requestBody));

//     if (response.statusCode == 200) {
//       print('FCM request sent successfully');
//     } else {
//       print('Failed to send FCM request. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   }

//   static Future<void> subscribeToTopic({required String topicName}) async {
//     await FirebaseMessaging.instance.subscribeToTopic(topicName);
//   }

//   static Future<void> unSubscribeFromTopic({required String topicName}) async {
//     await FirebaseMessaging.instance.unsubscribeFromTopic(topicName);
//   }

//   static Future<List<FireStoreUserModel>> getSearchedUser({
//     String? search,
//     String? personalUserId,
//   }) async {
//     print(search);
//     print(personalUserId);
//     try {
//       QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
//           .collection('users')
//           .where("searchWord", isGreaterThanOrEqualTo: search?.toLowerCase())
//           .where("searchWord",
//               isLessThanOrEqualTo: "${search?.toLowerCase()}\uf7ff")
//           .get();

//       print(snapshot.docs);

//       final users =
//           snapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
//         return FireStoreUserModel.fromDocumentSnapshot(doc);
//       }).toList();

//       print(users);

//       final filteredUsers =
//           users.where((user) => user.id != personalUserId).toList();
//       if (search == '') {
//         return [];
//       } else {
//         return filteredUsers;
//       }
//     } catch (e) {
//       print('ERROR $e');
//       return [];
//     }
//   }

//   static Future<FireStoreUserModel?> getUserById(
//       {required String userId}) async {
//     try {
//       final DocumentSnapshot userDoc =
//           await firestore.collection('users').doc(userId).get();

//       if (userDoc.exists) {
//         print(FireStoreUserModel.fromJson(
//             userDoc.data() as Map<String, dynamic>));
//         return FireStoreUserModel.fromJson(
//             userDoc.data() as Map<String, dynamic>);
//       } else {
//         return null; // User not found
//       }
//     } catch (e) {
//       print('Error getting user by ID: $e');
//       return null; // Handle error as needed
//     }
//   }

//   static Future<ChatModelDb?> getChatModelById({required String chatId}) async {
//     try {
//       final DocumentSnapshot userDoc =
//           await firestore.collection('chats').doc(chatId).get();

//       if (userDoc.exists) {
//         print(FireStoreUserModel.fromJson(
//             userDoc.data() as Map<String, dynamic>));
//         return ChatModelDb.fromJson(userDoc.data() as Map<String, dynamic>);
//       } else {
//         return null; // User not found
//       }
//     } catch (e) {
//       print('Error getting user by ID: $e');
//       return null; // Handle error as needed
//     }
//   }

//   static Future<void> saveNumberOFUnread(
//       {required List<String> ids,
//       required BuildContext context,
//       required ChatModelDb chatModelDb}) async {
//     Map<String, int> resultMap = {};

//     // Initialize resultMap with existing counts if available
//     if (chatModelDb.countJsonEncoded != null) {
//       resultMap = Map<String, int>.from(chatModelDb.countJsonEncoded!);
//     }

//     for (String key in resultMap.keys) {
//       if (key != context.read<GetUserDataCubit>().userData?.id) {
//         // Increment the value of each key by 1
//         resultMap[key] = resultMap[key]! + 1;
//       }
//     }

//     // Update countJsonEncoded in chatModelDb with resultMap
//     chatModelDb.countJsonEncoded = resultMap;

//     // Now you can update the database or perform any other actions as needed
//     // For example, you can call a function to update the database
//     await updateCountJsonEncodedInDatabase(resultMap, chatModelDb.id);

//     // Alternatively, if you're using a state management solution like Provider,
//     // you might want to notify listeners about the change in chatModelDb.
//   }

//   // Function to update countJsonEncoded in the database
//   static Future<void> updateCountJsonEncodedInDatabase(
//       Map<String, dynamic> resultMap, String? chatId) async {
//     DocumentReference chatRef = firestore.collection('chats').doc(chatId);

//     print(resultMap);

//     chatRef.update({'countJsonEncoded': resultMap});
//   }

//   static Future<void> zeroingNumberOfUnread({
//     required BuildContext context,
//     required ChatModelDb chatModelDb,
//   }) async {
//     Map<String, int> resultMap = {};

//     if (chatModelDb.countJsonEncoded != null) {
//       resultMap = Map<String, int>.from(chatModelDb.countJsonEncoded!);
//     }

//     for (String key in resultMap.keys) {
//       if (key == context.read<GetUserDataCubit>().userData?.id) {
//         // Increment the value of each key by 1
//         resultMap[key] = 0;
//       }
//     }
//     DocumentReference chatRef =
//         firestore.collection('chats').doc(chatModelDb.id);

//     print(resultMap);

//     chatRef.update({'countJsonEncoded': resultMap});
//   }
// }

// class ChatTest {
//   final String id;
//   final String label;
//   final List<dynamic> messages; // Assuming you have a list of messages here

//   ChatTest({
//     required this.id,
//     required this.label,
//     required this.messages,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'label': label,
//       'messages': messages,
//     };
//   }

//   factory ChatTest.fromJson(Map<String, dynamic> json) {
//     return ChatTest(
//       id: json['id'],
//       label: json['label'],
//       messages: json['messages'],
//     );
//   }
