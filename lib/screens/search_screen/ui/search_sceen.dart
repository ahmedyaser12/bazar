import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/widget/search_and_button_search.dart';
import 'package:book_shop/screens/search_screen/data/model.dart';
import 'package:book_shop/screens/search_screen/logic/search_screen_cubit.dart';
import 'package:book_shop/screens/search_screen/ui/widget/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SearchModel> _searchResults = [];

  @override
  void initState() {
    super.initState();
    //context.read<SearchCubit>().getSearchBook();
    context.read<SearchCubit>().searchController.addListener(
          _onSearchChanged,
        );
  }

  @override
  void dispose() {
    context
        .read<SearchCubit>()
        .searchController
        .removeListener(_onSearchChanged);
    context.read<SearchCubit>().searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    search(context.read<SearchCubit>().searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }
    context.read<SearchCubit>().getSearchBook();
    List<SearchModel> _results = [];
    context.read<SearchCubit>().bookSearch.forEach((element) {
      if (element.name!.toLowerCase().contains(query.toLowerCase())) {
        _results.add(element);
      }
    });

    setState(() {
      _searchResults = _results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyles.font18BlackBold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0, bottom: 20, right: 8.0),
              color: AppColors.whiteColor,
              child: SearchAndButtonSearch(
                controller: context.read<SearchCubit>().searchController,
                isButtonSearch: false,
                color: AppColors.gery50,
                iconColor: AppColors.blackColor,
                textTypingColor: AppColors.blackColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            heightSpace(20),
            _searchResults.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (ctx, index) {
                          return BlocBuilder<SearchCubit, SearchScreenState>(
                              builder: (ctx, state) {
                            if (state is LoadingList) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is ListSearchLoaded) {
                              //final searchList = state.searchBook;
                              return SearchResultWidget(
                                searchModel: _searchResults[index],
                              );
                            }
                            return Container();
                          });
                        }),
                  )
                : const Text('Search Result'),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController _searchController = TextEditingController();
//   List<String> _searchResults = [];
//   List<String> _allData = [
//     'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
//     'Fig', 'Grape', 'Honeydew', 'Item 9', 'Item 10'
//     // Assume this is your data to search from
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }
//
//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   _onSearchChanged() {
//     search(_searchController.text);
//   }
//
//   void search(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }
//
//     List<String> _results = [];
//     _allData.forEach((element) {
//       if (element.toLowerCase().contains(query.toLowerCase())) {
//         _results.add(element);
//       }
//     });
//
//     setState(() {
//       _searchResults = _results;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_searchResults[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
