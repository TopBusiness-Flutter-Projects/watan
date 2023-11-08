import 'package:elwatn/features/details/presentation/cubit/details_cubit.dart';
import 'package:elwatn/core/widgets/error_widget.dart' as error_widget;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/scound_main_item.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../home_page/domain/entities/main_item_domain_model.dart';

class AllUserPostsScreen extends StatefulWidget {
  const AllUserPostsScreen({Key? key, required this.mainItemModel})
      : super(key: key);
  final MainItem mainItemModel;

  @override
  State<AllUserPostsScreen> createState() => _AllUserPostsScreenState();
}

class _AllUserPostsScreenState extends State<AllUserPostsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<DetailsCubit>()
        .allUserPosts(widget.mainItemModel.userModel!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "${widget.mainItemModel.userModel!.name} Ads",
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is AllUserPostsLoading) {
            return const ShowLoadingIndicator();
          } else if (state is AllUserPostsLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    state.allPostsUser.data!.length,
                    (index) => SecondMainItemWidget(
                      mainItemModel: state.allPostsUser.data![index],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return error_widget.ErrorWidget(
              onPressed: () => context
                  .read<DetailsCubit>()
                  .allUserPosts(widget.mainItemModel.userModel!.id.toString()),
            );
          }
        },
      ),
    );
  }
}
