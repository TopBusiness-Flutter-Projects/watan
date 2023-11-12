import 'package:elwatn/features/bloggs/presentation/screens/bloggs.dart';
import 'package:elwatn/features/details/presentation/screens/details.dart';
import 'package:elwatn/features/filter/presentation/screens/filter.dart';
import 'package:elwatn/features/language/presentation/screens/language.dart';
import 'package:elwatn/features/register/presentation/screens/forget_password.dart';
import 'package:elwatn/features/register/presentation/screens/new_password.dart';
import 'package:elwatn/features/register/presentation/screens/reset_password.dart';
import 'package:elwatn/features/register/presentation/screens/welcome_register.dart';
import 'package:elwatn/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_strings.dart';
import '../../features/chat/data/models/MyRooms.dart';
import '../../features/contact_us/presentation/screens/contact_us.dart';
import '../../features/filter/presentation/screens/filter_result.dart';
import '../../features/login/presentation/screens/login.dart';
import '../../features/map/presentation/screens/map.dart';
import '../../features/notification/presentation/screens/notification.dart';
import '../../features/profile/presentation/screens/agency_screen.dart';
import '../../features/profile/presentation/screens/new_edit_agency.dart';
import '../../features/profile/presentation/widgets/loading_screen.dart';

class Routes {
  static MyRoomsDatum? chatModel;
  static bool isLogout = false;
  static const String initialRoute = '/';
  static const String notificationRoute = '/notification';
  static const String bloggsRoute = '/bloggs';
  static const String filterRoute = '/filter';
  static const String detailsRoute = '/details';
  static const String languageRoute = '/language';
  static const String detailsPhotoScreenRoute = '/detailsPhotoScreen';
  static const String loginScreenRoute = '/loginScreen';
  static const String welcomeRegisterRoute = '/welcomeRegister';
  static const String agencyScreenRoute = '/agencyScreen';
  static const String contactUsScreenRoute = '/contactUsScreen';
  static const String registerCompanyRoute = '/registerCompany';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String resetPasswordRoute = '/resetPassword';
  static const String newPasswordRoute = '/newPassword';
  static const String newAndEditAgencyScreenRoute = '/newAndEditAgencyScreen';
  static const String mapScreenRoute = '/mapScreen';
  static const String filterResultRoute = '/filterResult';
  static const String loadingScreenWidgetRoute = '/loadingScreenWidget';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.notificationRoute:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );
      case Routes.bloggsRoute:
        return MaterialPageRoute(
          builder: (context) => const BloggsScreen(),
        );
      case Routes.filterRoute:
        return MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        );
      case Routes.detailsRoute:
        return MaterialPageRoute(
          builder: (context) => const DetailsScreen(),
        );
      case Routes.languageRoute:
        return MaterialPageRoute(
          builder: (context) => const LanguageScreen(),
        );
      case Routes.filterResultRoute:
        return MaterialPageRoute(
          builder: (context) => const FilterResult(),
        );
      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.welcomeRegisterRoute:
        return MaterialPageRoute(
          builder: (context) => const WelcomeRegister(),
        );

      case Routes.agencyScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const AgencyScreen(),
        );
      case Routes.contactUsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => ContactUsScreen(),
        );
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => ForgetPasswordScreen(),
        );
      case Routes.resetPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => const ResetPassword(),
        );
      case Routes.newPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => NewPassword(),
        );
      case Routes.newAndEditAgencyScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const NewAndEditAgencyScreen(),
        );
      case Routes.loadingScreenWidgetRoute:
        return MaterialPageRoute(
          builder: (context) => const LoadingScreenWidget(),
        );
      case Routes.mapScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const MapScreen(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
