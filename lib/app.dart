import 'package:elwatn/features/show_more_posts/presentation/cubit/show_more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/locale/app_localizations_setup.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'features/add/presentation/cubit/add_ads_cubit.dart';
import 'features/add_project/presentation/cubit/add_project_cubit.dart';
import 'features/app_settings/presentation/cubit/app_setting_cubit.dart';
import 'features/bloggs/presentation/cubit/bloggs_cubit.dart';
import 'features/chat/presentation/screens/conversation_screen/cubit/conversation_page_cubit.dart';
import 'features/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'features/details/presentation/cubit/details_cubit.dart';
import 'features/favorite/presentation/cubit/favourites_cubit.dart';
import 'features/filter/presentation/cubit/filter_cubit.dart';
import 'features/home_page/presentation/cubit/home_page_cubit.dart';
import 'features/language/presentation/cubit/locale_cubit.dart';
import 'package:elwatn/injector.dart' as injector;

import 'features/login/presentation/cubit/login_cubit.dart';
import 'features/map/presentation/cubit/map_cubit.dart';
import 'features/my_ads/presentation/cubit/my_ads_cubit.dart';
import 'features/notification/presentation/cubit/notification_cubit.dart';
import 'features/packages/presentation/cubit/package_cubit.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/project_details/presentation/cubit/project_details_cubit.dart';
import 'features/register/presentation/cubit/register_cubit.dart';
import 'features/report_post/presentation/cubit/report_post_cubit.dart';
import 'features/show_lists/presentation/cubit/show_lists_cubit.dart';

class Watan extends StatelessWidget {
  const Watan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<LocaleCubit>()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<HomePageCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ShowMoreCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<RegisterCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<BloggsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<AppSettingCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<FilterCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<MapCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ShowListsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<DetailsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ContactUsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<MyAdsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<AddAdsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ProfileCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ReportPostCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ProjectDetailsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<PackageCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ConversationPageCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<AddProjectCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<FavouritesCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NotificationCubit>(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            locale: state.locale,
            theme: appTheme(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
          );
        },
      ),
    );
  }
}
