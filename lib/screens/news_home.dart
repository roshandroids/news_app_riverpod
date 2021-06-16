import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app_riverpod/controllers/news_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class NewsHome extends StatefulHookWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await refreshController.requestRefresh();
    await context.read(newsController).fetchNews(countryCode: countryCode);

    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future<void>.delayed(const Duration(seconds: 2));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    refreshController.loadComplete();
  }

  @override
  void initState() {
    context.read(newsController).fetchNews();
    super.initState();
  }

  String? countryCode;
  void chooseCountry() async {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        context
            .read(newsController)
            .fetchNews(countryCode: country.countryCode.toLowerCase());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => chooseCountry(), icon: const Icon(Icons.flag)),
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
              if (data.data!.articles.isNotEmpty) {
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: data.data!.articles.length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, item) {
                      final value = data.data?.articles[item];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color.fromRGBO(218, 165, 32, 1)
                              .withOpacity(0.3),
                          radius: 30,
                          child: CachedNetworkImage(
                            imageUrl: value?.urlToImage ?? '',
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: const CircleAvatar(
                                radius: 65,
                              ),
                            ),
                            imageBuilder: (context, img) {
                              return CircleAvatar(
                                backgroundColor:
                                    const Color.fromRGBO(218, 165, 32, 1)
                                        .withOpacity(0.3),
                                radius: 30,
                                backgroundImage: img,
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                        title: Text(value?.title ?? ''),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      const Text('No data for selected country !'),
                      ElevatedButton(
                        onPressed: () => chooseCountry(),
                        child: const Text('Choose another country'),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
