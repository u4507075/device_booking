import 'package:device_booking/features/deviceinfo/deviceinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './devicecomment_controller.dart';
import './devicecomment_model.dart';
import 'package:intl/intl.dart';
import 'package:device_booking/core/core.dart';

// class CommentSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//           child: Row(
//         children: [
//           CircleAvatar(
//             child: () Image.network(''),
//           )
//         ],
//       )),
//     );
//   }
// }

Widget addComment() {
  int textCount = 0;
  DeviceCommentController _controller = Get.put(DeviceCommentController());
  int maxLength = 50;
  TextEditingController textController = TextEditingController();

  void clear() {
    textController.clear();
    _controller.clear();
  }

  return StatefulBuilder(
    builder: (BuildContext context, setState) => Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                maxLength: maxLength,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                onChanged: (value) {
                  _controller.commentText = value;
                  setState(() {});
                },
                decoration: InputDecoration(
                        suffix: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${maxLength - textController.text.length}'),
                          ],
                        ),
                        border: OutlineInputBorder(),
                        // counter: Offstage(),
                        hintText: 'Add comment...',
                        // buildcounter
                        errorStyle: TextStyle(
                            height: double.minPositive,
                            color: Colors.transparent),
                        counterStyle: TextStyle(
                            height: double.minPositive,
                            color: Colors.transparent),
                        // counterText: ' ',
                        contentPadding: const EdgeInsets.all(15.0),
                        hintStyle: Theme.of(context).textTheme.bodyText2)
                    .copyWith(hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 20),
              icon: Icon(
                Icons.send_rounded,
                size: 25,
              ),
              color: Theme.of(context).iconTheme.color,
              highlightColor: Colors.grey,
              splashRadius: 25,
              onPressed: () async {
                FocusManager.instance.primaryFocus.unfocus();
                // _controller.addComment();
                // print('${Get.find<UserController>().user.toString()}');

                if (!Get.find<AuthController>().user.isAnonymous) {
                  clear();
                  setState(() {});
                } else {
                  Get.snackbar('Access is forbidden',
                      'Anonymous user cannot use this function');
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget commentSection(DeviceComment comment) {
  return Card(
    //Todo change to container later
    elevation: 0.0,
    child: InkWell(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: (comment.userPhotoURL != null &&
                                comment.userPhotoURL != '')
                            ? NetworkImage(
                                comment.userPhotoURL,
                              )
                            : AssetImage(
                                'assets/images/profile_placeholder.png',
                              ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: constraints.maxWidth - 70,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${comment?.displayName ?? 'User'}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${comment?.comment ?? ''}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w100),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${timeFormat(comment.time ?? DateTime(0))}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

String timeFormat(DateTime time) {
  var now = DateTime.now();
  Duration timeLapsed = time.difference(now);
  String text;

  timeLapsed.compareTo(Duration(minutes: 1)) < 0
      ? text = timeLapsed.inSeconds.toString() + ' seconds ago'
      : timeLapsed.compareTo(Duration(hours: 1)) < 0
          ? text = timeLapsed.inMinutes.toString() + ' minute(s) ago'
          : timeLapsed.compareTo(Duration(days: 1)) < 0
              ? text = timeLapsed.inHours.toString() + ' hour(s) ago'
              : timeLapsed.compareTo(Duration(days: 7)) < 0
                  ? text = timeLapsed.inDays.toString() + ' day(s) ago'
                  : text = timeLapsed.inDays.toString() + ' day(s) ago';
  // : timeLapsed.compareTo(Duration(days: 31)) < 0
  //     ? text = timeLapsed.in.toString() + ' week(s) ago'
  //     : text = DateFormat().format(time) + ' month(s) ago';

  return text;
}

//Todo add this https://api.flutter.dev/flutter/material/InkWell-class.html
