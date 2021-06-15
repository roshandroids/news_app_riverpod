import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/base_state/base_state.dart';
import 'package:news_app_riverpod/controllers/news_controller.dart';

class NewsHome extends StatefulHookWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  @override
  void initState() {
    context.read(newsController).fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read(newsController).fetchNews();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: HookBuilder(
        builder: (context) {
          final state = useProvider(newsController.state);
          return state.maybeMap(
            loading: (_) => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox(),
            success: (data) {
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: data.data!.articles.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, item) {
                  final value = data.data?.articles[item];
                  return Text(value!.title!);
                },
              );
            },
          );
        },
      ),
    );
  }
}
