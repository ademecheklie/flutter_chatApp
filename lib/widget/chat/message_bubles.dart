import 'package:flutter/material.dart';

class MessageBubles extends StatelessWidget {
  const MessageBubles(this.message, this.username, this.imageUrl, this.isMe,
      {@required this.kkey});
  final String message;
  final String username;
  final String imageUrl;
  final bool isMe;
  final Key kkey;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 200,
              padding: !isMe
                  ? const EdgeInsets.only(left: 2, bottom: 20, top: 12)
                  : const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: !isMe
                  ? const EdgeInsets.only(left: 15, bottom: 10, top: 30)
                  : const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft: !isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(10),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(10)),
                color:
                    isMe ? Colors.grey[600] : Color.fromARGB(255, 36, 142, 228),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        color: isMe ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(color: isMe ? Colors.black : Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isMe)
          Positioned(
              bottom: -23,
              left: 0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              )),
      ],
    );
  }
}
