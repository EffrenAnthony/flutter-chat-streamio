import 'package:chat_streamio/data_utils.dart';
import 'package:chat_streamio/firendsChat.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MainChat extends StatefulWidget {
  MainChat({Key key}) : super(key: key);

  @override
  _MainChatState createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  // Client _client;
  // @override
  // void initState() {
  //   _client = Client('he746td8zaht', logLevel: Level.INFO);
  //   super.initState();
  // }

  final _usernameControler = TextEditingController();
  String _usernameError;
  bool _loading = false;

  Future<void> _onGoPressed() async {
    final username = _usernameControler.text;
    print(username);
    if (username.isNotEmpty) {
      final client = StreamChat.of(context).client;
      final user = client.state.user;
      if (user == null) {
        setState(() {
          _loading = true;
        });
        // en realidad aqui deberiamos pasarle el otken de autenticación y el usuariocreado
        await client.setUser(
            User(
              id: username,
              extraData: {
                'image': DataUtils.getUserImage(username),
              },
            ),
            client.devToken(username));
        setState(() {
          _loading = false;
        });
      }
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FriendsChat(),
          ));
    } else {
      setState(() {
        _usernameError = 'User name is not valid';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = StreamChat.of(context).client;
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Chat'),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Card(
                elevation: 11,
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Welcome to the public chat'),
                      if (client.state.user == null)
                        TextField(
                          controller: _usernameControler,
                          decoration: InputDecoration(
                              hintText: 'UserName', errorText: _usernameError),
                        )
                      else
                        Text('Username: ${client.state.user.id}'),
                      ElevatedButton(
                          onPressed: _onGoPressed, child: Text('Go')),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
