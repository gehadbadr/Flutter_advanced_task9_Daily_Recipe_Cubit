import 'package:daily_recipe2/consts/consts.dart';
import 'package:daily_recipe2/cubit/auth_cubit.dart';
import 'package:daily_recipe2/reuseable_function/snackbar.function.dart';
import 'package:daily_recipe2/widgets/applogo.dart';
import 'package:daily_recipe2/widgets/custom_button.dart';
import 'package:daily_recipe2/widgets/custom_textfield.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _globalKey;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  bool? islogin = true;
  @override
  void initState() {
    _globalKey = GlobalKey<FormState>();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    init();
    super.initState();
  }

  void init() {
    BlocProvider.of<AuthCubit>(context).changeisLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    double height = context.screenHeight;

    return Scaffold(
    //  backgroundColor: ColorsApp.bgColor,
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is ChangeisLoading) {
            return BlurryModalProgressHUD(
              inAsyncCall: BlocProvider.of<AuthCubit>(context).isLoading,
              blurEffectIntensity: 4,
              dismissible: true,
              opacity: 0.4,
              color: Colors.black87,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    //
                    child: Image(
                        image: AssetImage(ImagesPath.imgBg), fit: BoxFit.fill),
                  ),
                  Container(
                      height: context.screenHeight,
                      width: context.screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: (height * 0.1),
                              ),
                              appLogoWidget(),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sign In',
                                style: TextStyle(
                                    color: ColorsApp.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.black38),
                                padding: EdgeInsets.all(16),
                                width: context.screenWidth - 70,
                                child: Form(
                                    key: _globalKey,
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          title: TextApp.email,
                                          hint: TextApp.emailHint,
                                          controller: emailController,
                                          icon: Icons.email,
                                          isPass: false,
                                          onClick: (value) {
                                            emailController.text = value!;
                                          },
                                        ),
                                        CustomTextField(
                                          title: TextApp.password,
                                          hint: TextApp.passwordHint,
                                          controller: passwordController,
                                          icon: Icons.lock,
                                          isPass: true,
                                          onClick: (value) {
                                            passwordController.text = value!;
                                          },
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: TextButton(
                                              onPressed: () {},
                                              child: Text(TextApp.forgetPass),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            width: context.screenWidth - 50,
                                            child: CustomButton(
                                              bgColor: ColorsApp.PKColor,
                                              textColor: ColorsApp.whiteColor,
                                              title: TextApp.login,
                                              onPress: () async {
                                                final authController =
                                                    BlocProvider.of<AuthCubit>(
                                                        context);
                                                authController
                                                    .changeisLoading(true);
                                                if (_globalKey.currentState!
                                                    .validate()) {
                                                  _globalKey.currentState
                                                      ?.save();
                                                  try {
                                                    String? emailValue =
                                                        authController.prefsFile
                                                            .getString('email');
                                                    String? passwordValue =
                                                        authController.prefsFile
                                                            .getString(
                                                                'password');

                                                    if (emailValue == null &&
                                                        passwordValue == null) {
                                                      authController
                                                          .changeisLoading(
                                                              false);
                                                      ShowSnackbar.showSnackbar(
                                                      context,
                                                      TextApp.errorNullloggedIn);
                                                
                                                    }else
                                                    if (emailValue !=
                                                            emailController
                                                                .text ||
                                                        passwordValue !=
                                                            passwordController
                                                                .text) {
                                                      authController
                                                          .changeisLoading(
                                                              false);
                                                              ShowSnackbar.showSnackbar(
                                                      context,
                                                      TextApp.errorloggedIn);
                                                
                                                      authController
                                                          .changeisLoading(
                                                              false);
                                                    } else {
                                                      authController.prefsFile
                                                          .setBool(
                                                              'login', true);
                                                      authController
                                                          .changeisLoading(
                                                              false);
                                                      VxToast.show(context,
                                                          msg:
                                                              TextApp.loggedIn);
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              'HomepageScreen/');
                                                    }
                                                  } catch (e) {
                                                    print(e.toString());
                                                    authController
                                                        .changeisLoading(false);
                                                  }
                                                } else {
                                                  authController
                                                      .changeisLoading(false);
                                                }
                                              },
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          TextApp.loginWith,
                                          style: TextStyle(
                                              color: ColorsApp.whiteColor),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              3,
                                              (index) => Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            ColorsApp.lightGrey,
                                                        radius: 25,
                                                        child: Image.asset(
                                                          ListsApp.socialIconList[
                                                              index],
                                                          width: 30,
                                                        )),
                                                  )),
                                        )
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: context.screenHeight / 7,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'SignupScreen/');
                                  },
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: TextApp.creatNewAccount,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: ColorsApp.fontGrey,
                                              fontSize: 16)),
                                      TextSpan(
                                          text: TextApp.register,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: ColorsApp.PKColor,
                                              fontSize: 16))
                                    ]),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            );
          } else {
            return "Error".text.makeCentered();
          }
        },
        listener: (context, state) {
          if (state is AuthError) {
            Text('Error');
          }
        },
      ),
    );
  }
}
