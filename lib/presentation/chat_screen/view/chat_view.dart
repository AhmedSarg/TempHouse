import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/data_intent/data_intent.dart';
import '../../common/widget/main_app_bar.dart';
import '../../common/widget/main_circle_processIndicator.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles.dart';
import '../../resources/values_manager.dart';
import '../chat_service/chat_services.dart';
import 'widgets/no_message_screen.dart';

class ChatScreen extends StatefulWidget {
  final String receiveEmail;
  final String receiveID;
  final String chatID;

  const ChatScreen({
    Key? key,
    required this.receiveEmail,
    required this.receiveID,
    required this.chatID,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMainAppBar(
        context,
        Row(
          children: [
            Container(
              width: AppSize.s40,
              height: AppSize.s40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                ImageAssets.unknownUserImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: AppSize.s10,
            ),
            Expanded(
              child: Text(
                widget.receiveEmail,
                style: AppTextStyles.chatScreenUserNameTextStyle(context),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatServices.getChatMessages(
        widget.chatID,
      ),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainCicleProcessIndicator();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return NoContent(content: AppStrings.chatNoMessages.tr());
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
        return ListView.builder(
          controller: _scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final message =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final isCurrentUser =
                message['senderID'] == DataIntent.getUser().uid;
            final messageType = message['type'];
            final messageContent = message['content'];
            final seen = message['seen'] ?? false;
            return _buildMessageBubble(
              isCurrentUser: isCurrentUser,
              messageType: messageType,
              messageContent: messageContent,
              seen: seen,
              timestamp: message['timestamp'],
            );
          },
        );
      },
    );
  }

  Widget _buildMessageBubble({
    required bool isCurrentUser,
    required String messageType,
    required String messageContent,
    required bool seen,
    required Timestamp timestamp,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p4,
        horizontal: AppPadding.p8,
      ),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            if (messageType == 'image') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.network(
                            messageContent,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: AppSize.s30,
                          left: AppSize.s20,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              size: AppSize.s35,
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: messageType == 'text'
                  ? (isCurrentUser
                      ? ColorManager.lightBlue
                      : ColorManager.lightGrey)
                  : (isCurrentUser ? Colors.transparent : Colors.transparent),
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            padding: const EdgeInsets.all(AppSize.s12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (messageType == 'text')
                  Text(
                    messageContent,
                    style: AppTextStyles.chatMessageTextStyle(context),
                  ),
                if (messageType == 'image')
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        child: Image.network(
                          messageContent,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: AppSize.s5),
                    ],
                  ),
                Text(
                  _formatTimestamp(timestamp),
                  style: AppTextStyles.chatTimeTextStyle(context),
                ),
                if (isCurrentUser && seen)
                  const Icon(
                    Icons.done_all,
                    color: ColorManager.blue,
                    size: AppSize.s20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Column(
      children: [
        const Divider(color: ColorManager.offwhite),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m16,
                  vertical: AppMargin.m20,
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                height: AppSize.s50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20),
                  border: Border.all(color: ColorManager.grey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: ColorManager.offwhite,
                        style: AppTextStyles.chatNoMessageTextStyle(context),
                        controller: _messageController,
                        decoration: InputDecoration.collapsed(
                          hintText: AppStrings.chatScreenInputHint.tr(),
                          hintStyle:
                              AppTextStyles.chatTextFieldHintTextStyle(context),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _getImagesFromGallery,
                      icon: const Icon(Icons.image,
                          size: AppSize.s30, color: ColorManager.white),
                    ),
                    IconButton(
                      onPressed: _getImagesFromCamera,
                      icon: const Icon(Icons.camera_alt,
                          size: AppSize.s30, color: ColorManager.white),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, size: AppSize.s30),
              color: ColorManager.white,
            ),
          ],
        ),
      ],
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    DateTime dateTime = (timestamp as Timestamp).toDate();
    return DateFormat('MMM d, h:mm a').format(dateTime);
  }

  void _sendMessage() async {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      Timestamp timestamp = Timestamp.now();
      _chatServices.sendMessage(
        widget.chatID,
        message,
        'text',
        timestamp,
      );
      _messageController.clear();

      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Future<void> _getImagesFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _sendImageMessage(File(pickedFile.path));
    }
  }

  Future<void> _getImagesFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _sendImageMessage(File(pickedFile.path));
    }
  }

  Future<void> _sendImageMessage(File imageFile) async {
    final Timestamp timestamp = Timestamp.now();
    String imageURL = await _uploadImageToStorage(imageFile);
    _chatServices.sendMessage(
      widget.chatID,
      imageURL,
      'image',
      timestamp,
    );
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('chat_images/${DateTime.now().millisecondsSinceEpoch}');
      TaskSnapshot uploadTask = await ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      String downloadURL = await uploadTask.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      if (kDebugMode) {
        print(
            'Error uploading image:________________________________________ $e');
      }
      return '';
    }
  }
}
