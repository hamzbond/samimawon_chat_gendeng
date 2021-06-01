import 'package:flutter/material.dart';
import 'chatPage.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 200),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 93.0,
                      backgroundColor: Colors.orangeAccent,
                      child: CircleAvatar(
                        radius: 90.0,
                        backgroundImage: NetworkImage(
                            'https://picsum.photos/id/1074/70/70'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Samiwamon',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.orangeAccent),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetails()))
                      },
                      child: Text('Aplikasi chat mirip simi simi, yuk mulai chat aku :)',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.orangeAccent,
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('built by hamzbond with '),
                      Icon(
                        Icons.favorite,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}