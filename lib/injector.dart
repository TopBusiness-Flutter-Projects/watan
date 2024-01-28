import 'package:dio/dio.dart';
import 'package:elwatn/features/home_page/domain/use_cases/get_add_and_popular_items_use_case.dart';
import 'package:elwatn/features/register/domain/use_cases/verifywhatsapp.dart';
import 'package:elwatn/features/show_more_posts/data/data_sources/show_more_data_source.dart';
import 'package:elwatn/features/show_more_posts/data/repositories/show_more_data_repositories.dart';
import 'package:elwatn/features/show_more_posts/domain/repositories/base_show_more_repositories.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'features/add/data/data_sources/add_ads_data_source.dart';
import 'features/add/data/repositories/add_ads_repositories.dart';
import 'features/add/domain/repositories/add_ads_base_repositories.dart';
import 'features/add/domain/use_cases/add_ads_use_case.dart';
import 'features/add/domain/use_cases/add_project_use_case.dart';
import 'features/add/domain/use_cases/update_ads_use_case.dart';
import 'features/add/presentation/cubit/add_ads_cubit.dart';
import 'features/add_project/presentation/cubit/add_project_cubit.dart';
import 'features/app_settings/data/data_sources/app_setting_data_source.dart';
import 'features/app_settings/data/repositories/app_setting_repositories.dart';
import 'features/app_settings/domain/repositories/base_app_setting_repositories.dart';
import 'features/app_settings/domain/use_cases/get_app_settings_use_case.dart';
import 'features/app_settings/presentation/cubit/app_setting_cubit.dart';
import 'features/bloggs/data/data_sources/bloggs_data_source.dart';
import 'features/bloggs/data/repositories/bloggs_repositories.dart';
import 'features/bloggs/domain/repositories/base_bloggs_repositories.dart';
import 'features/bloggs/domain/use_cases/get_bloggs_use_case.dart';
import 'features/bloggs/presentation/cubit/bloggs_cubit.dart';
import 'features/chat/data/data_sources/chat_data_source.dart';
import 'features/chat/data/repositories/chat_repositories.dart';
import 'features/chat/domain/repositories/base_chat_repositories.dart';
import 'features/chat/domain/use_cases/my_rooms_use_case.dart';
import 'features/chat/domain/use_cases/one_room_use_case.dart';
import 'features/chat/domain/use_cases/open_room_use_case.dart';
import 'features/chat/domain/use_cases/send_message_use_case.dart';
import 'features/chat/presentation/screens/conversation_screen/cubit/conversation_page_cubit.dart';
import 'features/contact_us/data/data_sources/contact_us_data_source.dart';
import 'features/contact_us/data/repositories/contact_us_repositories.dart';
import 'features/contact_us/domain/repositories/base_contact_us_repositories.dart';
import 'features/contact_us/domain/use_cases/post_contact_us_use_case.dart';
import 'features/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'features/details/data/data_sources/details_data_source.dart';
import 'features/details/data/repositories/details_repositories.dart';
import 'features/details/domain/repositories/base_details_repositories.dart';
import 'features/details/domain/use_cases/all_posts_for_user_use_case.dart';
import 'features/details/domain/use_cases/increase_view_use_case.dart';
import 'features/details/domain/use_cases/more_posts_use_case.dart';
import 'features/details/presentation/cubit/details_cubit.dart';
import 'features/favorite/data/data_sources/favourites_data_source.dart';
import 'features/favorite/data/repositories/favourites_repositories.dart';
import 'features/favorite/domain/repositories/base_favourites_repositories.dart';
import 'features/favorite/domain/use_cases/change_favourite_state_use_case.dart';
import 'features/favorite/domain/use_cases/my_favourites_use_case.dart';
import 'features/favorite/presentation/cubit/favourites_cubit.dart';
import 'features/filter/data/data_sources/filter_data_source.dart';
import 'features/filter/data/repositories/filter_data_repositories.dart';
import 'features/filter/domain/repositories/base_filter_repositories.dart';
import 'features/filter/domain/use_cases/filter_use_case.dart';
import 'features/filter/domain/use_cases/get_agent_list_use_case.dart';
import 'features/filter/domain/use_cases/get_amenities_use_case.dart';
import 'features/filter/domain/use_cases/get_cities_location_use_case.dart';
import 'features/filter/domain/use_cases/get_cities_use_case.dart';
import 'features/filter/presentation/cubit/filter_cubit.dart';
import 'features/home_page/data/data_sources/home_data_source.dart';
import 'features/home_page/data/repositories/home_data_repositories.dart';
import 'features/home_page/domain/repositories/base_home_repositories.dart';
import 'features/home_page/domain/use_cases/get_categories_use_case.dart';
import 'features/home_page/domain/use_cases/get_slider_use_case.dart';
import 'features/home_page/domain/use_cases/send_device_token_use_case.dart';
import 'features/home_page/presentation/cubit/home_page_cubit.dart';
import 'features/language/data/data_sources/language_locale_data_source.dart';
import 'features/language/data/repositories/language_repository.dart';
import 'features/language/domain/repositories/base_language_repository.dart';
import 'features/language/domain/use_cases/change_language_use_case.dart';
import 'features/language/domain/use_cases/get_saved_language_use_case.dart';
import 'features/language/presentation/cubit/locale_cubit.dart';
import 'features/login/data/data_sources/login_data_source.dart';
import 'features/login/data/repositories/login_repositories.dart';
import 'features/login/domain/repositories/base_login_repositories.dart';
import 'features/login/domain/use_cases/login_use_case.dart';
import 'features/login/domain/use_cases/logout_use_case.dart';
import 'features/login/presentation/cubit/login_cubit.dart';
import 'features/map/data/data_sources/map_data_source.dart';
import 'features/map/data/repositories/map_repositories.dart';
import 'features/map/domain/repositories/base_map_repositories.dart';
import 'features/map/domain/use_cases/get_all_location_use_case.dart';
import 'features/map/presentation/cubit/map_cubit.dart';
import 'features/my_ads/data/data_sources/my_ads_data_source.dart';
import 'features/my_ads/data/repositories/my_ads_repositories.dart';
import 'features/my_ads/domain/repositories/base_my_ads_repositories.dart';
import 'features/my_ads/domain/use_cases/change_status_use_case.dart';
import 'features/my_ads/domain/use_cases/delete_ads_use_case.dart';
import 'features/my_ads/domain/use_cases/my_ads_use_case.dart';
import 'features/my_ads/presentation/cubit/my_ads_cubit.dart';
import 'features/notification/data/data_sources/notifcation_data_source.dart';
import 'features/notification/data/repositories/notifications_repositories.dart';
import 'features/notification/domain/repositories/base_notifications_repositories.dart';
import 'features/notification/domain/use_cases/get_all_notification_use_case.dart';
import 'features/notification/presentation/cubit/notification_cubit.dart';
import 'features/notification/presentation/widgets/navigation.dart';
import 'features/packages/data/data_sources/package_data_source.dart';
import 'features/packages/data/repositories/package_repositories.dart';
import 'features/packages/domain/repositories/base_package_repositories.dart';
import 'features/packages/domain/use_cases/add_package_use_case.dart';
import 'features/packages/domain/use_cases/package_use_case.dart';
import 'features/packages/presentation/cubit/package_cubit.dart';
import 'features/profile/data/data_sources/profile_data_sources.dart';
import 'features/profile/data/repositories/profile_repositories.dart';
import 'features/profile/domain/repositories/base_profile_repositories.dart';
import 'features/profile/domain/use_cases/delete_agent_use_case.dart';
import 'features/profile/domain/use_cases/delete_user_account_use_case.dart';
import 'features/profile/domain/use_cases/edit_agent_use_case.dart';
import 'features/profile/domain/use_cases/get_agent_list_use_case.dart';
import 'features/profile/domain/use_cases/post_new_agent_use_case.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/project_details/data/data_sources/project_details_data_source.dart';
import 'features/project_details/data/repositories/project_details_repositories.dart';
import 'features/project_details/domain/repositories/base__project_details_repositories.dart';
import 'features/project_details/domain/use_cases/all_posts_for_project_use_case.dart';
import 'features/project_details/domain/use_cases/more_project_posts_use_case.dart';
import 'features/project_details/presentation/cubit/project_details_cubit.dart';
import 'features/register/data/data_sources/base_register_data_source.dart';
import 'features/register/data/repositories/register_repositories.dart';
import 'features/register/domain/repositories/base_registration_repositories.dart';
import 'features/register/domain/use_cases/check_code_use_case.dart';
import 'features/register/domain/use_cases/post_register_user_use_case.dart';
import 'features/register/domain/use_cases/reset_password_use_case.dart';
import 'features/register/domain/use_cases/send_code_use_case.dart';
import 'features/register/domain/use_cases/update_profile_use_case.dart';
import 'features/register/domain/use_cases/update_store_profile_use_case.dart';
import 'features/register/domain/use_cases/verifywhatsappcode.dart';
import 'features/register/presentation/cubit/register_cubit.dart';
import 'features/report_post/data/data_sources/report_data_source.dart';
import 'features/report_post/data/repositories/report_repositories.dart';
import 'features/report_post/domain/repositories/base_report_repositories.dart';
import 'features/report_post/domain/use_cases/post_report_use_case.dart';
import 'features/report_post/presentation/cubit/report_post_cubit.dart';
import 'features/show_lists/data/data_sources/show_lists_data_source.dart';
import 'features/show_lists/data/repositories/show_lists_data_repositories.dart';
import 'features/show_lists/domain/repositories/base_show_lists_repositories.dart';
import 'features/show_lists/domain/use_cases/pagination_show_list_use_case.dart';
import 'features/show_lists/domain/use_cases/pagination_show_projects_list_use_case.dart';
import 'features/show_lists/domain/use_cases/show_lists_use_case.dart';
import 'features/show_lists/domain/use_cases/show_projects_lists_use_case.dart';
import 'features/show_lists/presentation/cubit/show_lists_cubit.dart';
import 'features/show_more_posts/domain/use_cases/pagination_use_case.dart';
import 'features/show_more_posts/domain/use_cases/show_more_use_case.dart';
import 'features/show_more_posts/presentation/cubit/show_more_cubit.dart';
// import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
    () => LocaleCubit(
      getSavedLanguageUseCase: serviceLocator(),
      changeLanguageUseCase: serviceLocator(),
      logoutUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => HomePageCubit(
      getSliderUseCase: serviceLocator(),
      getCategoriesUseCase: serviceLocator(),
      getNewAndPopularItemsUseCase: serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ShowMoreCubit(
        getShowMoreUseCase: serviceLocator(),
        getPaginationUseCase: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(
      postLoginUseCase: serviceLocator(),
      sendDeviceTokenUseCase: serviceLocator(),
      updateStoreProfileUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => RegisterCubit(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => BloggsCubit(
      baseBloggsUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => AppSettingCubit(
      getAppSettingUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FilterCubit(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => AddAdsCubit(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => AddProjectCubit(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => MapCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ShowListsCubit(
        serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => DetailsCubit(serviceLocator(), serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ContactUsCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => MyAdsCubit(serviceLocator(), serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ProfileCubit(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ReportPostCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ProjectDetailsCubit(serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => PackageCubit(serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => ConversationPageCubit(
        serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => FavouritesCubit(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => NotificationCubit(
      serviceLocator(),
    ),
  );

  ///////////////////// Use Cases ////////////////////////

  serviceLocator.registerLazySingleton(
      () => GetSavedLanguageUseCase(languageRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ChangeLanguageUseCase(languageRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetSliderUseCase(baseHomeRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetCategoriesUseCase(baseHomeRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(() =>
      GetNewAndPopularItemsUseCase(baseHomeRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetShowMoreUseCase(baseShowMoreRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetPaginationUseCase(baseShowMoreRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => PostLoginUseCase(baseLoginRepositories: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => VerifyWhatsAppUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => VerifyWhatsAppCodeUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => PostRegisterUserUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetBloggsUseCase(baseBloggsRepositories: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => GetAppSettingsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetCitiesUseCase(baseFilterRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetCitiesLocationUseCase(baseFilterRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetAmenitiesUseCase(baseFilterRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetAgentUseCase(baseFilterRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetShowListsUseCase(baseShowListsRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetPaginationShowListUseCase(
      baseShowListsRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(() =>
      GetShowProjectsListsUseCase(baseShowListsRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(() =>
      GetPaginationShowProjectsListUseCase(
          baseShowListsRepositories: serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => IncreaseViewUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => PostContactUSUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetMyAdsUseCase(baseMyAdsRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(() =>
      GetFiltersResponseUseCase(baseFilterRepositories: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetAgentProfileListUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => PostNewAgentUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteAgentUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => EditAgentUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => PostReportUseCase(
      baseReportRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => MorePostsUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AllPostsForUserUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AllPostsForProjectUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => MoreProjectPostsUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetPackageUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteUserAccountUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetMyRoomsUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetOneRoomUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SendMessageUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateStoreProfileUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateProfileUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SendCodeUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => CheckCodeUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ResetPasswordUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AddPackageUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => OpenRoomUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteMyAdsUseCase(
      baseMyAdsRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ChangeStatusMyAdsUseCase(
      baseMyAdsRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AddAdsUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AddProjectUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateAdsUseCase(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetMyFavouritesUseCase(
      baseFavoritesRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ChangeStatusFavouritesUseCase(
      baseFavoritesRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetAllLocationsUseCase(
      baseMapRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetAllNotificationUseCase(
      baseNotificationsRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => SendDeviceTokenUseCase(
      baseHomeRepositories: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogoutUseCase(
      baseLoginRepositories: serviceLocator(),
    ),
  );

  //////////////////////// Repositories ////////////////////////

  serviceLocator.registerLazySingleton<BaseLanguageRepository>(
    () => LanguageRepository(
      languageLocaleDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseHomeRepositories>(
    () => HomePageRepositories(
      homePageDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseShowMoreRepositories>(
    () => ShowMoreRepositories(
      showDataDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseLoginRepositories>(
    () => LoginRepositories(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseRegistrationRepositories>(
    () => RegisterRepositories(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseBloggsRepositories>(
    () => BloggsRepositories(
      baseBloggsDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseAppSettingsRepositories>(
    () => AppSettingRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseFilterRepositories>(
    () => FilterRepositories(
      baseFilterDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseShowListsRepositories>(
    () => ShowListsRepositories(
      showListsDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseIncreaseViewRepositories>(
    () => IncreaseViewRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseContactUsRepositories>(
    () => ContactUsRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseMyAdsRepositories>(
    () => MyAdsRepositories(
      baseMyAdsDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseProfileRepositories>(
    () => ProfileRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseReportRepositories>(
    () => ReportRepositories(
      baseReportDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseProjectDetailsRepositories>(
    () => ProjectDetailsRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BasePackageRepositories>(
    () => PackageRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseChatRepositories>(
    () => ChatRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseAddAdsRepositories>(
    () => AddAdsRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseFavoritesRepositories>(
    () => FavoritesRepositories(
      baseFavouritesDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseMapRepositories>(
    () => MapRepositories(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<BaseNotificationsRepositories>(
    () => NotificationRepositories(
      serviceLocator(),
    ),
  );

  //////////////////////// Data Sources ////////////////////////

  serviceLocator.registerLazySingleton<BaseLanguageLocaleDataSource>(
      () => LanguageLocaleDataSource(sharedPreferences: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseHomePageDataSource>(
      () => HomePageDataSource(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseShowDataDataSource>(
      () => ShowMoreDataSource(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseLoginDataSource>(
      () => LoginDataSource(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseRegistrationDataSource>(
      () => RegistrationDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseBloggsDataSource>(
      () => BloggsDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseAppSettingDataSource>(
      () => AppSettingDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseFilterDataSource>(
      () => FilterDataSource(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseShowListsDataSource>(
      () => ShowListsDataSource(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseDetailsDataSource>(
      () => DetailsDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseContactUsDataSource>(
      () => ContactUsDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseMyAdsDataSource>(
      () => MyAdsDataSource(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseProfileDataSource>(
      () => ProfileDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseReportDataSource>(
      () => ReportDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseProjectDetailsDataSource>(
      () => ProjectDetailsDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BasePackageDataSource>(
      () => PackageDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseChatDataSource>(
      () => ChatDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseAddAdsDataSource>(
      () => AddAdsDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseFavouritesDataSource>(
      () => FavouritesDataSource(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<BaseMapDataSource>(
      () => MapDataSource(serviceLocator()));
  serviceLocator.registerLazySingleton<BaseNotificationsDataSource>(
      () => NotificationsDataSource(serviceLocator()));

  //! Core
  //Network
  serviceLocator.registerLazySingleton(() => NavigationService());
  serviceLocator.registerLazySingleton<BaseNetworkInfo>(
      () => NetworkInfo(connectionChecker: serviceLocator()));

  // Api Consumer
  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  // http
  // serviceLocator.registerLazySingleton(() => http.Client());

  // Dio
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => AppInterceptors());
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );

  // Internet Connection Checker
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
