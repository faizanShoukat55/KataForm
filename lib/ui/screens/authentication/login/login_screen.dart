// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/enums/view_state.dart';
import '../../../custom_widgets/button/rounded_button.dart';
import '../../../custom_widgets/image_container.dart';
import '../../../custom_widgets/text_feild/input_text_field.dart';
import '../../animals_list/animal_list_screen.dart';
import '../reset_password/reset_password_screen.dart';
import '../sign_up/sign_up_screen.dart';
import 'login_view_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.loading,
          progressIndicator: const CircularProgressIndicator(
            color: primaryColor,
          ),
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text("Channab", style: appBarTextStyle),
              backgroundColor: backgroundColor,
              elevation: 0.0,
              actions: [
                ImageContainer(
                  width: 26.sp,
                  height: 15.sp,
                  assets: IconPath.menuIcon,
                  radius: 0,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 15.w,
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(18.sp, 145.sp, 18.sp, 20.sp),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back ",
                        style: poppinTextStyle.copyWith(
                          color: primaryColor,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        "Login to conitnue",
                        style: poppinTextStyle.copyWith(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await model.loginWithFacebook();
                              if (model.authResult.status!) {
                                Get.offAll(() => HomeScreen());
                              } else {
                                // ignore: avoid_print
                                print('.......login failed.....');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Login Error'),
                                      content: Text(
                                          model.authResult.errorMessage ??
                                              'Login Failed'),
                                    );
                                  },
                                );
                              }
                            },
                            icon: ImageContainer(
                              height: 40.sp,
                              width: 40.sp,
                              assets: IconPath.facebookIcon,
                              radius: 0,
                              fit: BoxFit.cover,
                            ),
                          ),

                          IconButton(
                            onPressed: () async {
                              await model.loginWithGoogle();
                              if (model.authResult.status!) {
                                Get.offAll(() => HomeScreen());
                              } else {
                                // ignore: avoid_print
                                print('.......login failed.....');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Login Error'),
                                      content: Text(
                                          model.authResult.errorMessage ??
                                              'Login Failed'),
                                    );
                                  },
                                );
                              }
                            },
                            icon: ImageContainer(
                              height: 40.sp,
                              width: 40.sp,
                              assets: IconPath.googleIcon,
                              radius: 0,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // IconButton(
                          //   onPressed: (){},
                          //   icon: ImageContainer(
                          //     height: 40.sp,
                          //     width: 40.sp,
                          //     assets: IconPath.appleIcon,
                          //     radius: 0,
                          //     fit: BoxFit.cover,
                          //   ),),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      InputTextField(
                        validation: (String? val) {
                          if (val!.isEmpty || val.length < 1) {
                            return "Please Enter email";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Email or Mobile Number",
                        onChanged: (val) {},
                        controller: model.emailTextEditingController,
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      InputTextField(
                        hintText: "Password",
                        validation: (String? val) {
                          if (val!.isEmpty || val.length < 1) {
                            return "Please Enter  password";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {},
                        isPasswordActive: model.isOpen,
                        controller: model.passwordTextEditingController,
                        suffixIcon: InkWell(
                          onTap: () {
                            model.updatePasswordStatus();
                          },
                          child: model.isOpen
                              ? Icon(
                                  Icons.visibility,
                                  color: primaryColor,
                                  size: 25.sp,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: primaryColor,
                                  size: 25.sp,
                                ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => ResetPasswordScreen());
                            },
                            child: Text(
                              "Forget Password?",
                              style: poppinTextStyle.copyWith(
                                color: primaryColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 65.h,
                      ),
                      RoundedButton(
                        text: "Login",
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            await model.loginWithEmailPassword();

                            if (model.authResult.status!) {
                              Get.offAll(() => HomeScreen());
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  title: Text('Invalid credentials'),
                                  content: Text(
                                      'invalid credential, please try again'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Text(
                        "or",
                        style: poppinTextStyle.copyWith(
                          color: primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      RoundedButton(
                        text: "Sign Up",
                        press: () {
                          Get.to(() => SignUpScreen());
                        },
                        color: lightSilverColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }




  ///........Reversed Just Alphabets in a string...........
  void reversedTheString() {
    var oldList = [];
//   oldList.addAll(["a", "b", "-", "c", "d"]);
    oldList.addAll([
      "a",
      "-",
      "b",
      "c",
      "-",
      "d",
      "e",
      "f",
      "=",
      "g",
      "h",
      "i",
      "j",
      "!",
      "!"
    ]);

    var alphabetList = returnAlphabetListFunction(oldList);
    var reversedAlphabetList = reverseAlphabetListFunction(alphabetList);
    var mergeList = requiredListFunction(oldList, reversedAlphabetList);

    print(alphabetList.toString());
    print(reversedAlphabetList.toString());
    print(mergeList.toString());
  }

  ///.......Return Just Alphabets.............
  List returnAlphabetListFunction(List list) {
    var alphabetList = [];
    for (int i = 0; i < list.length; i++) {
      var regExp = RegExp('^[a-zA-Z]+');
      if (list[i].contains(regExp)) {
        alphabetList.add(list[i]);
      }
    }
    return alphabetList;
  }

  ///.......Return Reversed Alphabets List.............
  List reverseAlphabetListFunction(List list) {
    var reversedAlphabetList = [];
    for (int i = list.length - 1; i >= 0; i--) {
      reversedAlphabetList.add(list[i]);
    }
    return reversedAlphabetList;
  }

//.......Merge Two List.............
  List requiredListFunction(List oldList, List reversedList) {
    var count = 0;
    for (int i = 0; i < oldList.length; i++) {
      var regExp = RegExp('^[a-zA-Z]+');
      if (oldList[i].contains(regExp)) {
        var charAtFirst = reversedList[count];
        count++;
        oldList[i] = charAtFirst;
      }
    }
    return oldList;
  }




  ///..........Two same strings with a new char find new char..........
  void findNewChar(){
    var s="abcd";
    var t="ceadb";

    var new_letter="";
    var s_list=s.characters;
    for(int i=0;i<s_list.length;i++){
      if (s_list.characterAt(i).contains(t)) {

      }else{
        new_letter=s_list.characterAt(i).string;
      }
    }

    print(new_letter);
  }
}
