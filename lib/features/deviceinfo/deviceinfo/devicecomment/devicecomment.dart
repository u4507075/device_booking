import 'package:device_booking/core/auth/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './devicecomment_controller.dart';
import './devicecomment_model.dart';
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
    _controller.clearComment();
  }

  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      void submit() async {
        print('userId: ${_controller.comment.userId}');
        print('comment: ${_controller.comment.comment}');
        print('deviceId: ${_controller.comment.deviceId}');

        FocusManager.instance.primaryFocus!.unfocus();
        if (Get.find<UserController>().developermode) {
          Get.snackbar('Comment submitted', 'developermode enabled');
          _controller.addComment();
        } else {
          if (Get.find<AuthController>().firebaseUser!.isAnonymous == true) {
            Get.snackbar('Access is forbidden',
                'Anonymous user cannot use this function');
          } else {
            print('Comment add success');
            _controller.addComment();
          }
        }
        clear();
        setState(() {});
        // Get.find<DeviceCommentListController>().initialize();
      }

      return Container(
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
                onPressed: () =>
                    textController.text.trim() != '' ? submit() : null,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget commentList() {
  var _controller = Get.put(DeviceCommentListController());
  _controller.initialize();

  // return Expanded(child: ListView());
  // return Text('${comments[0]?.displayName}');
  // print(comments.length);
  return Column(
    children: [
      Container(
        child: GetX<DeviceCommentListController>(
          init: _controller,
          builder: (controller) {
            // List<DeviceComment?> comments = List.from(controller.list.reversed);
            List<DeviceComment?> comments =
                controller.list.reversed.toList() as List<DeviceComment?>;

            if (comments.length != 0) {
              return ListView.builder(
                itemCount: comments.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return commentSection(comments[index]);
                },
              );
            } else {
              return Text('No comments');
            }
          },
        ),
      ),
    ],
  );
}

Widget commentSection(DeviceComment? comment) {
  //Todo change this later, view should not directly use Service
  UserDataService _service = UserDataService();

  return Card(
    //Todo change to container later
    elevation: 3.0,
    child: InkWell(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return StreamBuilder<UserData>(
              stream: _service.streamUserData(comment?.userId ?? ''),
              builder: (context, snapshot) {
                // if(snapshot.)
                if (snapshot.hasData) {
                  var user = snapshot.data;
                  // print("Hi ${user?.photoURL}");
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
                              // CircleAvatar( //todo fix this null safety
                              //   backgroundImage: NetworkImage((user.photoURL)
                              //       ?
                              //       /*user?.photoURL ??*/
                              //       'https://device-tracking-system.obs.ap-southeast-2.myhuaweicloud.com/img/profile_placeholder.png'
                              //       : user!.photoURL),
                              // ),
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
                                '${user?.firstname ?? 'Anon'}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${comment?.comment?.trim() ?? ''}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w100),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${timeFormat(comment?.time ?? DateTime(0))}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              });
        },
      ),
    ),
  );
}

Widget seeMoreComment() {
  return Obx(() {
    if (!Get.find<DeviceCommentListController>().isAll) {
      return LayoutBuilder(
          builder: (context, constraints) => TextButton(
                onPressed: () {
                  Get.find<DeviceCommentListController>().seeMoreComment();
                  print(
                      'Numbers of comments: ${Get.find<DeviceCommentListController>().numbers}');
                },
                child: Text('See more comments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.blue)),
              ));
    } else {
      return Container();
    }
  });
}

String timeFormat(DateTime time) {
  var now = DateTime.now();
  Duration timeLapsed = now.difference(time);
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
