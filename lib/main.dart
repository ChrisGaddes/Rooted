import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(RootedApp());

final ThemeData kIOSTheme = new ThemeData(
  // TODO look up why certain variables start with k
  primaryColor: Color(0xFF9CC2BF),
  // Use "primarySwatch" if Material colors
  primaryColorBrightness: Brightness.light,
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.black,
  primarySwatch: Colors.green,
  accentColor: Color.fromARGB(255, 250, 250, 250),
//  primaryTextTheme: TODO: Add primary TextTheme and IconTheme
// TODO: Make IOSTheme and AndroidTheme different
);

final ThemeData kAndroidTheme = new ThemeData(
  primaryColor: Color(0xFF9CC2BF),
  // Use "primarySwatch" if Material colors
  primaryColorBrightness: Brightness.light,
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.black,
  primarySwatch: Colors.green,
  accentColor: Color.fromARGB(255, 250, 250, 250),
//  primaryTextTheme: TODO: Add primary TextTheme and IconTheme
);

class RootedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rooted',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kAndroidTheme,
      home: ChatScreen(),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          padding: EdgeInsets.only(left: 80.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  color: Theme.of(context).primaryColor,
                ),
                padding: EdgeInsets.all(12.0),
                child: Text(
                  text,
//                  'Hey! How are you doing this morning? You\'re the cutest when you\'re sleepy... I love you SOOOOOO much!!! :)',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                  backgroundImage: ExactAssetImage('images/cat.jpg')
//              new NetworkImage(snapshot.value['senderPhotoUrl'])

                  ),
            ),
          ])),
      Container(
          padding: EdgeInsets.only(left: 94.0),
          child: Text(
              '8:00 AM')) //TODO fix it so you don't have to have padding in both places
    ]));
    return null;
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];

  // TODO change these variable names
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage( //new
      text: text, //new
    ); //new
    setState(() { //new
      _messages.insert(0, message); //new
    }); //new
  }

  Widget _buildTextButton(String title, bool isOnLight) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: isOnLight ? Theme
              .of(context)
              .primaryColor : Colors.white,
        ),
      ),
      onPressed: null,
    );
  }

  Widget _buildChatTextComposer() {
    return new IconTheme(
      data: new IconThemeData(
          color: Theme //TODO figure out what this does
              .of(context)
              .accentColor),
      child: Container(
//          color: Theme.of(context).primaryColor,
        margin: EdgeInsets.only(bottom: 12.0),
        child: new Container(
            color: Theme
                .of(context)
                .primaryColorLight,
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(children: [
              Container(
                child:
                IconButton(icon: Icon(Icons.attach_file), onPressed: null),
//                  margin: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Flexible(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Theme
                          .of(context)
                          .accentColor,
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: null,
                      // null makes text wrap
                      controller: _textController,
                      onSubmitted: _handleSubmitted,
                      onChanged: (String text) {
                        setState(() {
                          _isComposing = text.length > 0;
                        });
                      },
//              onSubmitted: _handleSubmitted,
                      decoration:
                      new InputDecoration.collapsed(hintText: "Message"),
                    )),
              ),
              Container(
                height: 50.0,
                child: IconButton(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    //TODO figure out why icons are not effected by color
                    icon: Icon(Icons.send),
                    padding: EdgeInsets.all(8.0),
                    onPressed: () => _handleSubmitted(_textController.text)),
              )
            ])),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
          actions: [
            _buildTextButton('settings'.toUpperCase(), true),
          ]),
      body: new Column( //modified
        children: <Widget>[ //new
          new Flexible( //new
            child: new ListView.builder( //new
              padding: new EdgeInsets.all(8.0), //new
              reverse: true, //new
              itemBuilder: (_, int index) => _messages[index], //new
              itemCount: _messages.length, //new
            ), //new
          ), //new
          new Divider(height: 1.0), //new
          new Container( //new
            decoration: new BoxDecoration(
                color: Theme
                    .of(context)
                    .cardColor), //new
            child: _buildChatTextComposer(), //modified
          ), //new
        ], //new
      ), //new
    );
  }
}

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//          backgroundColor: Colors.white,
//          elevation: 0.0,
//          brightness: Brightness.light,
//          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
//          leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
//          actions: [
//            _buildTextButton('settings'.toUpperCase(), true),
//          ]),
//      body: Column(children: [
//        Expanded(
//            child: ListView(
//          //TODO this breaks if ListView is not in expanded...
//          reverse: true,
//          shrinkWrap: true, //TODO figure out what shrinkWrap does
////            padding: EdgeInsets.all(12.0),
//          children: [
//            ChatMessage(),
////            ChatMessage(),
////            ChatMessage(),
////            ChatMessage(),
////            ChatMessage(),
////            ChatMessage(),
////            ChatMessage(),
//          ],
//        )),
//        _buildChatTextComposer()
//      ]),
//    );
//  }
//}
