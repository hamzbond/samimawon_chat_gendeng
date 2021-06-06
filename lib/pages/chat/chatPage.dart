import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


List chats = [
  {
    'message': 'Hi, chat aku yuk',
    'isMe': false
  },
];

TextEditingController chatController = TextEditingController();
ScrollController scrollController = ScrollController();

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: CircleAvatar(
                radius: 90.0,
                backgroundImage: NetworkImage(
                    'https://picsum.photos/id/1074/40/40'),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Samimawon',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Online terus buat kamu *wink',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: chats.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Bubble(
                            message: chats[index]['message'],
                            isMe: chats[index]['isMe'],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(-2, 0),
                  blurRadius: 5,
                ),
              ]),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context, 
                              builder: (BuildContext context) {
                                return RatingStarFull(starCount: 5, rating: 5, onRatingChanged: (rat) {setState(() {this._rating = rat;});}, color: Theme.of(context).primaryColor);
                              }
                            );
                          }, 
                          icon: Icon(Icons.star),
                        ),
                        Text('Rate me')
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: chatController,
                      decoration: InputDecoration(
                        hintText: 'Enter Message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if(chatController.text != '') {
                        chats.add({
                          'message': chatController.text,
                          'isMe': true
                        });
                        getReply(chatController.text);
                        chatController.text = '';
                        scrollController.jumpTo(scrollController.position.maxScrollExtent);
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getReply(msg) {
    http.get(Uri.parse('https://fdciabdul.tech/api/ayla/?pesan=${msg}')).then((value) => {
      chats.add({
        'message': jsonDecode(value.body)['jawab'],
        'isMe': false
      }),
      scrollController.jumpTo(scrollController.position.maxScrollExtent),
      FocusScope.of(context).requestFocus(new FocusNode()),
      setState(() {})
    });
  }
}

class Bubble extends StatelessWidget {
  final bool isMe;
  final String message;

  Bubble({required this.message, required this.isMe});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                              0.1,
                              1
                            ],
                          colors: [
                              Color(0xFFF6D365),
                              Color(0xFFFDA085),
                            ])
                      : LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                              0.1,
                              1
                            ],
                          colors: [
                              Color(0xFFEBF5FC),
                              Color(0xFFEBF5FC),
                            ]),
                  borderRadius: isMe
                      ? BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(15),
                        )
                      : BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(0),
                        ),
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


typedef void RatingChangeCallback(double rating);

class RatingStarFull extends StatefulWidget {

  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  RatingStarFull({required this.starCount, required this.rating, required this.onRatingChanged, required this.color});

  @override
  State<StatefulWidget> createState() {
    return _RatingStarState(starCount, rating, onRatingChanged, color);
  }

}

class _RatingStarState extends State<RatingStarFull> {

  final int starCount;
  double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;


  _RatingStarState(this.starCount, this.rating, this.onRatingChanged,
      this.color);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: Theme.of(context).primaryColor,
      );
    }
    return new GestureDetector(
      onTap: onRatingChanged == null ? null : () {
        onRatingChanged(index + 1.0);
        setState(() {
          this.rating = index + 1.0;
        });
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: new List.generate(starCount, (index) => buildStar(context, index)
        )
    );
  }
}