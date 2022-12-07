import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  var dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Icon(Icons.arrow_back_ios),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Image.asset('assets/logo/noimage.png'),
              ),
            ],
          ),
        ),
        title: WillPopScope(
          onWillPop: () {
            if (controller.isShowEmoji.isTrue) {
              controller.isShowEmoji.value = false;
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lorem Ipsum',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'Statusnya lorem',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  ItemChat(
                    dt: dt,
                    isSender: true,
                  ),
                  ItemChat(
                    dt: dt,
                    isSender: false,
                  ),
                  ItemChat(
                    dt: dt,
                    isSender: true,
                  ),
                  ItemChat(
                    dt: dt,
                    isSender: false,
                  ),
                  ItemChat(
                    dt: dt,
                    isSender: true,
                  ),
                  ItemChat(
                    dt: dt,
                    isSender: false,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: controller.isShowEmoji.isTrue
                    ? 5
                    : context.mediaQueryPadding.bottom),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: TextFormField(
                      controller: controller.chatController,
                      focusNode: controller.focnode,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Ketikan Pesan',
                        prefixIcon: IconButton(
                            onPressed: () {
                              controller.focnode.unfocus();
                              controller.isShowEmoji.toggle();
                            },
                            icon: Icon(Icons.emoji_emotions_outlined)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Material(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.teal,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => (controller.isShowEmoji.isTrue)
              ? Container(
                  height: 325,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      controller.addEmojiInChat(emoji);
                    },
                    onBackspacePressed: () {
                      controller.delEmojiInChat();
                    },
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 *
                          (foundation.defaultTargetPlatform ==
                                  TargetPlatform.iOS
                              ? 1.30
                              : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.RECENT,
                      bgColor: Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      noRecents: const Text(
                        'No Recents',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ), // Needs to be const Widget
                      loadingIndicator:
                          const SizedBox.shrink(), // Needs to be const Widget
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                    ),
                  ),
                )
              : SizedBox()),
        ],
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
    required this.dt,
  }) : super(key: key);
  final bool isSender;

  final DateTime dt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: isSender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(10),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(10),
                    ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              'Hi dokter aku mengalami gelaja xxx',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text('${dt.hour}:${dt.minute}'),
        ],
      ),
    );
  }
}
