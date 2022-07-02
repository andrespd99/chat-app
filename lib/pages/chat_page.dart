import 'package:chat/consts.dart';
import 'package:chat/models/chat_message.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = 'chat';

  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  List<ChatMessage> messages = [];

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  final Duration duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('private-message', listenToMessages);
    super.initState();
  }

  void listenToMessages(dynamic data) {
    final message = ChatMessage(
      uid: data['from'],
      text: data['message'],
      controller: AnimationController(vsync: this, duration: duration),
    );

    setState(() {
      messages.insert(0, message);
    });

    message.controller.forward().then((value) => message.controller.dispose());
  }

  @override
  Widget build(BuildContext context) {
    final User user = chatService.to!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                child: Text(user.name.substring(0, 2)),
                backgroundColor: Colors.blue.shade100,
              ),
              const SizedBox(height: Consts.padding / 4),
              Text(
                user.name,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.separated(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (_, i) => ChatMessageWidget(messages[i]),
                separatorBuilder: (_, i) => const SizedBox(height: 8.0),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
              ),
            ),
            const SizedBox(height: 8.0),
            BottomInputBox(
              onMessageSent: (text) => _onMessageSent(text),
            ),
          ],
        ),
      ),
    );
  }

  void _onMessageSent(String text) {
    text = text.trim();
    if (text.isEmpty) return;

    final newMessage = ChatMessage(
      uid: '123',
      text: text,
      controller: AnimationController(
        vsync: this,
        duration: duration,
      ),
    );
    messages.insert(0, newMessage);
    newMessage.controller.forward();

    setState(() {});
    socketService.emit('private-message', {
      'from': authService.currentUser?.uid,
      'message': text,
      'to': chatService.to?.uid,
      'epoch': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  void dispose() {
    socketService.socket.off('private-message');

    super.dispose();
  }
}

class BottomInputBox extends StatefulWidget {
  final Function(String) onMessageSent;

  const BottomInputBox({
    required this.onMessageSent,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomInputBox> createState() => _BottomInputBoxState();
}

class _BottomInputBoxState extends State<BottomInputBox> {
  late final bottomPadding = MediaQuery.of(context).padding.bottom;

  final controller = TextEditingController();
  String get message => controller.text;

  final Color backgroundColor = Colors.grey.shade100;

  late final primaryColor = Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Consts.padding / 2),
            color: backgroundColor,
            // height: 60.0 + bottomPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: SizedBox(
                    child: TextField(
                      controller: controller,
                      inputFormatters: [],
                      onChanged: (value) => setState(() {}),
                      maxLines: 5,
                      minLines: 1,
                      style: const TextStyle(fontSize: 18.0),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Consts.padding,
                          vertical: 5.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Consts.padding / 2),
                message.isEmpty
                    ? SizedBox(
                        height: 40.0,
                        child: IconButton(
                          onPressed: () => _handleSubmit(),
                          icon: const Icon(Icons.attach_file),
                        ),
                      )
                    : SizedBox(
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () => _handleSubmit(),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            fixedSize: const Size(5.0, 5.0),
                          ),
                          // backgroundColor: Colors.teal.shade300,
                          // foregroundColor: Colors.teal.shade100,
                          child: const Center(
                            child: Icon(Icons.arrow_upward_rounded),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          // Container(
          //   height: bottomPadding,
          //   color: backgroundColor,
          // )
        ],
      ),
    );
  }

  void _handleSubmit() {
    message.trim();
    widget.onMessageSent(message);
    controller.clear();
  }
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageWidget(
    this.message, {
    Key? key,
  }) : super(key: key);

  bool get _myMessage => message.uid == '123';

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: message.controller,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: message.controller,
          curve: Curves.easeOutCubic,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Consts.padding / 2),
          child: Align(
            alignment:
                _myMessage ? Alignment.centerRight : Alignment.centerLeft,
            child: messageBubble(),
          ),
        ),
      ),
    );
  }

  Widget messageBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Consts.padding / 2,
        vertical: Consts.padding / 3,
      ),
      decoration: BoxDecoration(
          color: _myMessage ? Colors.teal.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(20.0)),
      child: Text(
        message.text,
        textAlign: TextAlign.right,
      ),
    );
  }
}
