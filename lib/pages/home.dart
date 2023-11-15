import 'package:fetch_api_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && context.read<UserProvider>().hasMore) {
      context.read<UserProvider>().fetchUser();
    }
  }

  Future _onRefresh() async {
    context.read<UserProvider>().refresh();
  }

  @override
  void initState() {
    context.read<UserProvider>().fetchUser();
    _scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Consumer<UserProvider>(builder: (_, state, __) {
          return ListView.builder(
              controller: _scrollController,
              itemCount:
                  state.hasMore ? state.users.length + 1 : state.users.length,
              itemBuilder: (context, index) {
                if (index < state.users.length) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(state.users[index].profilePicture ?? ''),
                    ),
                    title: Text(state.users[index].name ?? ''),
                    subtitle: Text(state.users[index].email ?? ''),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                }
              });
        }),
      ),
    );
  }
}
