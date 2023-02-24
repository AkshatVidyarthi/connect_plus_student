import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  const TextMessageModel({
    required String? senderName,
    required String? sederUID,
    required String? recipientName,
    required String? recipientUID,
    required String messageType,
    required String message,
    required String messageId,
    required Timestamp time,
  }) : super(
          senderName: senderName,
          sederUID: sederUID,
          recipientName: recipientName,
          recipientUID: recipientUID,
          messsageType: messageType,
          message: message,
          messageId: messageId,
          time: time,
        );

  factory TextMessageModel.fromSnapShot(DocumentSnapshot snapshot) {
    return TextMessageModel(
      senderName: snapshot.get('senderName'),
      sederUID: snapshot.get('sederUID'),
      recipientName: snapshot.get('recipientName'),
      recipientUID: snapshot.get('recipientUID'),
      messageType: snapshot.get('messageType'),
      message: snapshot.get('message'),
      messageId: snapshot.get('messageId'),
      time: snapshot.get('time'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "sederUID": sederUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "messageType": messsageType,
      "message": message,
      "messageId": messageId,
      "time": time,
    };
  }
}
