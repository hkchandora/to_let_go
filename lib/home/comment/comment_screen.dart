import 'package:flutter/material.dart';
import 'package:to_let_go/util/Colors.dart';
import 'package:to_let_go/util/asset_image_path.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 40,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.fromLTRB(14, 6, 14, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(AssetImagePath.profileAvatar),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("User Name"),
                                  Text("Comment text message jdhask dckahdbcknda ckckbadkjf alsd loas fka skld asl ldnalkf am cla c,s kjs ls "),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
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
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 2,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Icon(Icons.send),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
