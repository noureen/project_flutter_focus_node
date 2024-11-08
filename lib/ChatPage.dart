import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late FocusNode _focusNode;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode(debugLabel: "chatfocusnode");
  }

  _hideKeyboardSolutions() {
    //To hide Keyboard solution - 1 (A temporary solution)
    FocusScope.of(context).unfocus();
    print(
        "Solution1- FocusScope Info: ${FocusScope.of(context).nearestScope}"); //Info: FocusScopeNode#6e22f(_ModalScopeState<dynamic> Focus Scope [IN FOCUS PATH])(context: FocusScope, IN FOCUS PATH, focusedChildren: [FocusNode#c394a([PRIMARY FOCUS])], traversalEdgeBehavior: TraversalEdgeBehavior.parentScope)

    //To hide Keyboard solution - 2 (Working)
/*
        FocusManager.instance.primaryFocus?.unfocus();
        print(
            "Solution2- FocusManager Info: ${FocusScope.of(context).nearestScope}"); //FocusScopeNode#9dfd6(_ModalScopeState<dynamic> Focus Scope [IN FOCUS PATH])(context: FocusScope, IN FOCUS PATH)
*/

    //To hide Keyboard solution - 3 (Working)
/*        _focusNode.unfocus();
        print(
            "Solution3- FocusManager Info: ${FocusScope.of(context).nearestScope}"); //FocusScopeNode#9dfd6(_ModalScopeState<dynamic> Focus Scope [IN FOCUS PATH])(context: FocusScope, IN FOCUS PATH)
      */

    //To hide Keyboard solution - 4 (Working)
/*
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    print(
        "Solution4- FocusManager Info: ${FocusScope.of(context).nearestScope}"); //FocusScopeNode#9dfd6(_ModalScopeState<dynamic> Focus Scope [IN FOCUS PATH])(context: FocusScope, IN FOCUS PATH)
*/
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboardSolutions();
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10, top: 10, right: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    _buildHorizontalDivider(),
                    Expanded(
                      child: TextField(
                        focusNode: _focusNode,
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    _buildHorizontalDivider(),
                    FloatingActionButton(
                      onPressed: () {
                        _hideKeyboardSolutions();
                        _buildBottomSheet(); // On closing bottomsheet keyboard re-appear automatically
                      },
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Build Widgets
  _buildHorizontalDivider() => const SizedBox(
        width: 15,
      );

  _buildBottomSheet() => showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 350.0,
          color: Colors.transparent,
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: const Center(
                child: Text("This is share modal sheet"),
              )),
        );
      });
}
