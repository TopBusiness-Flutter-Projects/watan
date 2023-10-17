import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/features/bloggs/presentation/widgets/bloggs_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/bloggs_cubit.dart';
import 'package:elwatn/core/widgets/error_widget.dart' as error_widget;

class BloggsScreen extends StatefulWidget {
  const BloggsScreen({Key? key}) : super(key: key);

  @override
  State<BloggsScreen> createState() => _BloggsScreenState();
}

class _BloggsScreenState extends State<BloggsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BloggsCubit>().getBloggs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.bloggsText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        actions: [Image.asset(ImageAssets.logoIcon)],
      ),
      body: BlocBuilder<BloggsCubit, BloggsState>(
        builder: (BuildContext context, state) {
          if (state is BloggsLoading) {
            return const ShowLoadingIndicator();
          } else if (state is BloggsLoaded) {
            return Column(
              children: [
                Expanded(

                  child: state.bloggs.data!.length>0?ListView.separated(
                      itemBuilder: (context, index) =>
                          BloggsItem(bloggsDatum: state.bloggs.data![index]),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 18),
                      itemCount: state.bloggs.data!.length):
                  Center(
                    child: Text(translateText("no_data", context),
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            );
          }else{
            return error_widget.ErrorWidget(
              onPressed: () =>
                  context.read<BloggsCubit>().getBloggs(),
            );
          }

        },
      ),
    );
  }
}
