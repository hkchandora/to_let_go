import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_let_go/home/comment/comment_controller.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/asset_image_path.dart';
import 'package:to_let_go/util/strings.dart';
import 'package:to_let_go/widget/LoadingDialogWidget.dart';

class CommentScreen extends StatefulWidget {
  String? userID;
  String? username;

  String? profileImage;
  String? videoID;
  CommentScreen(this.userID, this.username, this.profileImage, this.videoID, {Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  CommentController commentController = Get.put(CommentController());
  TextEditingController commentTextEditingController = TextEditingController();
  String? userFirebaseToken;
  String? name;
  List commentList = [];
  bool isApiCalling = true;

  @override
  void initState() {
    getAllComments();
    super.initState();
  }

  getAllComments() async {
    String? nameAndToken;
    nameAndToken = await commentController.getNameAndFirebaseTokenByUserId(widget.userID!);
    name = nameAndToken.split("&&")[0];
    userFirebaseToken = nameAndToken.split("&&")[1];
    commentList = await commentController.getAllVideoComment(widget.videoID!);
    setState(() {
      isApiCalling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: isApiCalling ? const Center(child: Text(Strings.loading)) :
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.fromLTRB(14, 6, 14, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(commentList[index]['profileImage']),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(commentList[index]['username'], style: const TextStyle(fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 4),
                                  Text(commentList[index]['commentText']),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(index % 2 == 0 ? AssetImagePath.like : AssetImagePath.unlike, height: 32, width: 32,
                                color: index % 2 == 0 ? colorDarkRed : colorWhite)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Card(
                  child: Row(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(widget.profileImage!)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: commentTextEditingController,
                          textCapitalization: TextCapitalization.sentences,
                          minLines: 2,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          LoadingDialogWidget.showDialogLoading(context, Strings.pleaseWait);
                          await commentController.addComment(
                            widget.videoID!,
                            widget.username!,
                            name!,
                            widget.profileImage!,
                            userFirebaseToken!,
                            commentTextEditingController.text.toString().trim(),
                          );
                          commentTextEditingController.clear();
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
