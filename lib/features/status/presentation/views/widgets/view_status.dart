import 'package:chat_app/core/model/status_model.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/status/presentation/views/widgets/image_viewer_widget.dart';
import 'package:chat_app/features/status/presentation/views/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:story_view/story_view.dart";

class ViewStatus extends StatefulWidget {
  final StatusModel status;
  const ViewStatus({super.key, required this.status});
  @override
  ViewStatusState createState() => ViewStatusState();
}

List<StoryItem> filterStatus(StatusModel status, StoryController controller) {
  List<StoryItem> storyItems = [];
  for (var statu in status.statusDetails) {
    if (statu.type == 'video') {
      storyItems.add(StoryItem.pageVideo(statu.url, controller: controller));
    } else {
      storyItems
          .add(StoryItem.pageImage(url: statu.url, controller: controller));
    }
  }
  return storyItems;
}

class ViewStatusState extends State<ViewStatus> {
  final controller = StoryController();
  final List<StoryItem> storyItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storyItems.addAll(filterStatus(widget.status, controller));
    print('story itemmmmmmmmmmmmssssssssssssssssssss');
    print(storyItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                width: 42.w, // Adjust the width as needed
                height: 42.w, // Maintain aspect ratio for a circle
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                  width: 16.0), // Add spacing between avatar and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.status.name,
                      style: Styles.textSytle15.copyWith(fontSize: 15.sp),
                    ),
                    // Text(
                    //   "Today 12:00 PM",
                    //   style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: StoryView(
    storyItems:storyItems,
    controller: controller, // pass controller here too
    repeat: false, // should the stories be slid forever
    // onStoryShow: (s) {notifyServer(s)},
    onComplete: () {Navigator.pop(context);},
    onVerticalSwipeComplete: (direction) {
      if (direction == Direction.down) {
        Navigator.pop(context);
      }
    }, // To disable vertical swipe gestures, ignore this parameter.
      // Preferrably for inline story view.
  ));
  }
}
