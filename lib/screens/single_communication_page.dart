import 'dart:async';
import 'dart:io';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../entity/my_chat_entity.dart';
import '../entity/text_message_entity.dart';
import '../model/my_chat_model.dart';
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
  final String photo;

  const SingleCommunicationPage(
    this.uid,
    this.otherUID, {
    Key? key,
    this.senderUID,
    this.recipientUID,
    this.senderName,
    this.recipientName,
    this.recipientPhoneNumber,
    this.senderPhoneNumber,
    required this.photo,
  }) : super(key: key);

  @override
  _SingleCommunicationPageState createState() =>
      _SingleCommunicationPageState();
}

class _SingleCommunicationPageState extends State<SingleCommunicationPage> {
  final ImagePicker _picker = ImagePicker();
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
                child: Image.network('${widget.photo}'),
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
                /*print(message.sederUID);
                print(widget.senderUID);*/
                if (message.sederUID == widget.senderUID) {
                  return _messageLayout(
                    color: Colors.white,
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
                      IconButton(
                          onPressed: () {
                            {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 120,
                                    width: 100,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text('FROM CAMERA',
                                                  style: GoogleFonts.arsenal(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              IconButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  final XFile? image =
                                                      await _picker.pickImage(
                                                    source: ImageSource.camera,
                                                    maxHeight: 500,
                                                    maxWidth: 500,
                                                    imageQuality: 50,
                                                  );
                                                  if (image != null) {
                                                    uploadProfile(image);
                                                  }
                                                  setState(() {});
                                                },
                                                icon: const Icon(Icons.camera),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('FROM GALLERY',
                                                  style: GoogleFonts.arsenal(
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              IconButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  final XFile? image =
                                                      await _picker.pickImage(
                                                    source: ImageSource.gallery,
                                                    maxHeight: 500,
                                                    maxWidth: 500,
                                                    imageQuality: 50,
                                                  );
                                                  if (image != null) {
                                                    uploadProfile(image);
                                                  }
                                                  setState(() {});
                                                },
                                                icon: const Icon(Icons.image),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            ;
                          },
                          icon: Icon(Icons.link_outlined)),
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
                Icons.send,
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
                    style: const TextStyle(fontSize: 14),
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

  void _sendTextMessage() async {
    final channelId =
        await getOneToOneSingleUserChannelId(widget.uid, widget.otherUID);
    if (_textMessageController.text.isNotEmpty) {
      sendTextMessage(
          TextMessageEntity(
            messsageType: "TEXT",
            message: _textMessageController.text,
            messageId: "",
            time: Timestamp.now(),
            senderName: FirebaseAuth.instance.currentUser?.displayName,
            sederUID: widget.uid,
            recipientUID: widget.otherUID,
            recipientName: widget.recipientName,
          ),
          channelId);
      await addToMyChat(MyChatEntity(
        channelId: channelId,
        recentTextMessage: _textMessageController.text,
        recipientName: widget.recipientName,
        senderUID: widget.uid,
        recipientUID: widget.otherUID,
        time: Timestamp.now(),
        profileURL: widget.photo,
        senderName: FirebaseAuth.instance.currentUser?.displayName,
      ));
      _textMessageController.clear();
    }
  }

  Future<void> addToMyChat(MyChatEntity myChatEntity) async {
    final myChatRef = FirebaseFirestore.instance
        .collection('users')
        .doc(myChatEntity.senderUID)
        .collection('myChat');

    final otherChatRef = FirebaseFirestore.instance
        .collection('users')
        .doc(myChatEntity.recipientUID)
        .collection('myChat');

    final myNewChat = MyChatModel(
      time: myChatEntity.time,
      senderName: myChatEntity.senderName,
      senderUID: myChatEntity.senderPhoneNumber,
      recipientUID: myChatEntity.recipientUID,
      recipientName: myChatEntity.recipientName,
      channelId: myChatEntity.channelId,
      isArchived: myChatEntity.isArchived,
      isRead: myChatEntity.isRead,
      profileURL: myChatEntity.profileURL,
      recentTextMessage: myChatEntity.recentTextMessage,
      recipientPhoneNumber: myChatEntity.recipientPhoneNumber,
      senderPhoneNumber: myChatEntity.senderPhoneNumber,
    ).toDocument();
    final otherNewChat = MyChatModel(
      time: myChatEntity.time,
      senderName: myChatEntity.recipientName,
      senderUID: myChatEntity.recipientUID,
      recipientUID: myChatEntity.senderUID,
      recipientName: myChatEntity.senderName,
      channelId: myChatEntity.channelId,
      isArchived: myChatEntity.isArchived,
      isRead: myChatEntity.isRead,
      profileURL: myChatEntity.profileURL,
      recentTextMessage: myChatEntity.recentTextMessage,
      recipientPhoneNumber: myChatEntity.senderPhoneNumber,
      senderPhoneNumber: myChatEntity.recipientPhoneNumber,
    ).toDocument();

    myChatRef.doc(myChatEntity.recipientUID).get().then((myChatDoc) {
      if (!myChatDoc.exists) {
        //Create
        myChatRef.doc(myChatEntity.recipientUID).set(myNewChat);
        otherChatRef.doc(myChatEntity.senderUID).set(otherNewChat);
        return;
      } else {
        //Update
        myChatRef.doc(myChatEntity.recipientUID).update(myNewChat);
        otherChatRef.doc(myChatEntity.senderUID).update(otherNewChat);
        return;
      }
    });
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

void uploadProfile(XFile image) async {
  final user = FirebaseAuth.instance.currentUser;
  final ref = FirebaseStorage.instance.ref("profilePhotos/${user?.uid}");
  final uploadTask = ref.putFile(File(image.path));
  uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
    switch (taskSnapshot.state) {
      case TaskState.running:
        final progress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        print("Upload is $progress% complete.");
        break;
      case TaskState.paused:
        print("Upload is paused.");
        break;
      case TaskState.canceled:
        print("Upload was canceled");
        break;
      case TaskState.error:
        print("Upload was error");
        // Handle unsuccessful uploads
        break;
      case TaskState.success:
        final url = await ref.getDownloadURL();
        print("Upload was success $url");
        user?.updatePhotoURL(url);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .set({
          "photo": url,
        }, SetOptions(merge: true));

        //ref.getDownloadURL();
        // Handle successful uploads on complete
        // ...
        break;
    }
  });
}
