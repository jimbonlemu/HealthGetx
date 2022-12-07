import 'package:emoji_picker_flutter/src/emoji.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  var isShowEmoji = false.obs;

  late FocusNode focnode;
  late TextEditingController chatController;

  @override
  void onInit() {
    chatController = TextEditingController();
    focnode = FocusNode();
    focnode.addListener(() {
      if (focnode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    focnode.dispose();
    chatController.dispose();
    super.onClose();
  }

  void addEmojiInChat(Emoji emoji) {
    chatController.text = chatController.text + emoji.emoji;
  }

  void delEmojiInChat() {
    chatController.text =
        chatController.text.substring(0, chatController.text.length - 2);
    // chatController.text = chatController.text.substring();
  }
}
