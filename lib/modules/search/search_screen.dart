import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';

import '../../Helper/custom_article_item.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var list = NewsCubit.get(context).search;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: searchController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                NewsCubit.get(context).getSearch(value: value);
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Search Must not be Empty';
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Search'),
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            ConditionalBuilder(
              condition:list.length !=0 ,
              builder: (context) => Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) =>CustomArticleItem(article: list[index]),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(thickness: 3),
                  ),
                ),
              ),
              fallback: (context) => Center(child: Container()),
            )
          ],
        ),
      ),
    );
  },
);
  }
}
