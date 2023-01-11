import 'package:elwatn/config/routes/app_routes.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/snackbar_method.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../language/presentation/cubit/locale_cubit.dart';
import '../../../navigation_bar/presentation/screens/navigator_bar.dart';
import '../../../register/presentation/screens/welcome_register.dart';
import '../cubit/login_cubit.dart';
import '../widgets/body_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.loginText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          if (state is SocialLoginSuccess) {
            context.read<LoginCubit>().updateLoginStoreData();
          }
        },
        builder: (BuildContext context, state) {
          if (state is LoginLoading) {
            return const ShowLoadingIndicator();
          } else if (state is LoginLoaded) {
            if (state.loginModel.code == 200) {
              if (state.loginModel.data!.user!.phone != null) {
                Future.delayed(
                  const Duration(milliseconds: 400),
                  () {
                    context.read<LocaleCubit>().getStoreUser();
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 1300),
                          child: NavigatorBar(
                            loginDataModel:
                                context.read<LoginCubit>().userLoginModel!,
                          ),
                        ),
                        ModalRoute.withName(Routes.loginScreenRoute));
                    Future.delayed(
                      const Duration(milliseconds: 700),
                      () {
                        context.read<LoginCubit>().loginSuccessfully();
                      },
                    );
                  },
                );
              } else {
                Future.delayed(
                  const Duration(milliseconds: 400),
                  () {
                    context.read<LocaleCubit>().getStoreUser();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 1300),
                        child: const WelcomeRegister(),
                      ),
                    );
                    Future.delayed(
                      const Duration(milliseconds: 700),
                      () {
                        context.read<LoginCubit>().loginSuccessfully();
                      },
                    );
                  },
                );
              }
              return const ShowLoadingIndicator();
            } else if (state.loginModel.code == 411) {
              Future.delayed(const Duration(milliseconds: 400), () {
                snackBar(
                  translateText(AppStrings.login411message, context),
                  context,
                  color: AppColors.error,
                );
              });
              return LoginBodyWidget();
            } else {
              Future.delayed(const Duration(milliseconds: 400), () {
                snackBar(
                  translateText(AppStrings.login406message, context),
                  context,
                  color: AppColors.error,
                );
              });

              return LoginBodyWidget();
            }
          } else if (state is LoginLoadedError) {
            Future.delayed(const Duration(milliseconds: 400), () {
              snackBar(
                translateText(AppStrings.serverFail, context),
                context,
                color: AppColors.error,
              );
            });
            return LoginBodyWidget();
          } else {
            return LoginBodyWidget();
          }
        },
      ),
    );
  }
}
