import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Helper/custom_article_item.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
       List<dynamic> list = NewsCubit.get(context).business;
        return ConditionalBuilder(

          condition:state is !NewsGetBusinessLoadingState ,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) =>CustomArticleItem(article: list[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Divider(thickness: 3),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
