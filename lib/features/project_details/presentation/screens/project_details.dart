import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../details/presentation/widgets/bottom.dart';
import '../../../details/presentation/widgets/communcation.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';
import '../../../login/data/models/login_data_model.dart';
import '../cubit/project_details_cubit.dart';
import '../widgets/header_project_widget.dart';
import '../widgets/project_all_details.dart';
import '../widgets/project_amenities_widget.dart';
import '../widgets/project_location_widget.dart';
import '../widgets/project_overview.dart';
import '../widgets/project_payment_plan_widget.dart';
import '../widgets/project_property_widget.dart';
import '../widgets/project_provided_by_widget.dart';
import '../widgets/simple_details_widget.dart';
import '../widgets/unit_details_and_floor_plans_widget.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({Key? key, required this.mainProjectItemModel})
      : super(key: key);
  final MainProjectItem mainProjectItemModel;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  late LoginDataModel loginDataModel;
  bool isFavourite = false;
  bool isLoading = false;

  _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      loginDataModel = LoginDataModel.fromJson(userMap);
      if (loginDataModel.data!.accessToken != null) {
        _morePostsDetails();
      }
    }
  }

  _morePostsDetails() {
    context
        .read<ProjectDetailsCubit>()
        .moreProjectPostsDetails(widget.mainProjectItemModel.id.toString());
  }

  @override
  void initState() {
    super.initState();
    isFavourite = widget.mainProjectItemModel.isFavourite!;
    _getStoreUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ProjectHeaderWidget(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              const SizedBox(height: 12),
              ProjectSimpleDetailsWidget(
                  mainProjectItemModel: widget.mainProjectItemModel),
              const Divider(thickness: 1),
              ProjectLocationWidget(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              const Divider(thickness: 1),
              ProjectAllDetailsWidget(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              const Divider(thickness: 1),
              ProjectAmenitiesWidget(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              const Divider(thickness: 1),
              ProjectOverView(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              const Divider(thickness: 1),
              ProjectPaymentPlan(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              const Divider(thickness: 1),
              UnitDetailsFloorPlansWidget(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              const Divider(thickness: 1),
              ProjectProvidedByWidget(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              BottomWidget(
                mainProjectItemModel: widget.mainProjectItemModel,
                mainItemModel: null,
                type: "project",
              ),
              const Divider(thickness: 1),
              ProjectPropertyWidget(
                mainProjectItemModel: widget.mainProjectItemModel,
              ),
              const Divider(thickness: 1),
              CommunicationWidget(
                phone: widget.mainProjectItemModel.phone ?? "0",
                whatsapp: widget.mainProjectItemModel.whatsapp ?? '0',
                type: 'project',
                userId: widget.mainProjectItemModel.userId!,
                postId: widget.mainProjectItemModel.id!,
              ),
              const Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
