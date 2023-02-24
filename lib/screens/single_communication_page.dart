import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entity/text_message_entity.dart';
import '../model/text_message_model.dart';

class SingleCommunicationPage extends StatefulWidget {
  final String? senderUID;
  final String? recipientUID;
  final String? senderName;
  final String? recipientName;
  final String? recipientPhoneNumber;
  final String? senderPhoneNumber;
  final String? uid;
  final String? otherUID;

  const SingleCommunicationPage(this.uid, this.otherUID,
      {Key? key,
      this.senderUID,
      this.recipientUID,
      this.senderName,
      this.recipientName,
      this.recipientPhoneNumber,
      this.senderPhoneNumber})
      : super(key: key);

  @override
  _SingleCommunicationPageState createState() =>
      _SingleCommunicationPageState();
}

class _SingleCommunicationPageState extends State<SingleCommunicationPage> {
  final TextEditingController _textMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    /*BlocProvider.of<CommunicationCubit>(context).getMessages(
      senderId: widget.senderUID,
      recipientId: widget.recipientUID,
    );*/
    _textMessageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _textMessageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        flexibleSpace: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              BackButton(
                color: Colors.white,
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('assets/profile_default.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${widget.recipientName}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body:
          _bodyWidget() /*BlocBuilder<CommunicationCubit, CommunicationState>(
        builder: (_, communicationState) {
          if (communicationState is CommunicationLoaded) {
            return _bodyWidget(communicationState);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )*/
      ,
    );
  }

  Widget _bodyWidget() {
    return Column(
      children: [
        _messagesListWidget(),
        _sendMessageTextField(),
      ],
    );
  }

  Widget _messagesListWidget() {
    return Expanded(
      child: StreamBuilder(
          stream: getMessages(),
          builder: (context, snapShot) {
            final messages = snapShot.data ?? [];
            return ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (_, index) {
                final message = messages[index];

                if (message.sederUID == widget.senderUID) {
                  return _messageLayout(
                    color: Colors.lightGreen[400],
                    time: DateFormat('hh:mm a').format(message.time.toDate()),
                    align: TextAlign.left,
                    boxAlign: CrossAxisAlignment.start,
                    crossAlign: CrossAxisAlignment.end,
                    nip: BubbleNip.rightTop,
                    text: message.message,
                  );
                } else {
                  return _messageLayout(
                    color: Colors.white,
                    time: DateFormat('hh:mm a').format(message.time.toDate()),
                    align: TextAlign.left,
                    boxAlign: CrossAxisAlignment.start,
                    crossAlign: CrossAxisAlignment.start,
                    nip: BubbleNip.leftTop,
                    text: message.message,
                  );
                }
              },
            );
          }),
    );
  }

  Stream<List<TextMessageEntity>> getMessages() async* {
    final channelId =
        await getOneToOneSingleUserChannelId(widget.uid, widget.otherUID);
    final messagesRef = FirebaseFirestore.instance
        .collection("myChatChannel")
        .doc(channelId)
        .collection('messages');

    yield* messagesRef.orderBy('time').snapshots().map(
          (querySnap) => querySnap.docs
              .map((doc) => TextMessageModel.fromSnapShot(doc))
              .toList(),
        );
  }

  Future<String?> getOneToOneSingleUserChannelId(
      String? uid, String? otherUid) {
    final userCollectionRef = FirebaseFirestore.instance.collection('users');
    return userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((engagedChatChannel) {
      if (engagedChatChannel.exists) {
        return engagedChatChannel.data()?['channelId'];
      }
      return Future.value(null);
    });
  }

  Widget _sendMessageTextField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        offset: const Offset(0.0, 0.50),
                        spreadRadius: 1,
                        blurRadius: 1),
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 60,
                      ),
                      child: Scrollbar(
                        child: TextField(
                          maxLines: null,
                          style: const TextStyle(fontSize: 14),
                          controller: _textMessageController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.link),
                      const SizedBox(
                        width: 10,
                      ),
                      _textMessageController.text.isEmpty
                          ? const Icon(Icons.camera_alt)
                          : const Text(""),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              if (_textMessageController.text.isNotEmpty) {
                _sendTextMessage();
              }
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Icon(
                _textMessageController.text.isEmpty ? Icons.mic : Icons.send,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _messageLayout({
    text,
    time,
    color,
    align,
    boxAlign,
    nip,
    crossAlign,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    textAlign: align,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(
                        .4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _sendTextMessage() async{
    final channelId =
    await getOneToOneSingleUserChannelId(widget.uid, widget.otherUID);
    if (_textMessageController.text.isNotEmpty) {
      sendTextMessage(
        TextMessageEntity(messsageType: "TEXT", message: _textMessageController.text, messageId: "", time: Timestamp.now()),
          channelId
      );
      _textMessageController.clear();
    }
  }

  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity,
      String? channelId,
      ) async {
    final messageRef = FirebaseFirestore.instance
        .collection('myChatChannel')
        .doc(channelId)
        .collection('messages');

    final messageId = messageRef.doc().id;

    final newMessage = TextMessageModel(
      message: textMessageEntity.message,
      messageId: messageId,
      messageType: textMessageEntity.messsageType,
      recipientName: textMessageEntity.recipientName,
      recipientUID: textMessageEntity.recipientUID,
      sederUID: textMessageEntity.sederUID,
      senderName: textMessageEntity.senderName,
      time: textMessageEntity.time,
    ).toDocument();

    messageRef.doc(messageId).set(newMessage);
  }
}
