// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katta_form/ui/screens/authentication/sign_up/sign_up_view_model.dart';
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

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child)=> ModalProgressHUD(
          inAsyncCall: model.state == ViewState.loading,
          progressIndicator: const CircularProgressIndicator(color: primaryColor,),
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

                SizedBox(width: 15.w,),
              ],
            ),


            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(18.sp, 113.sp, 18.sp, 20.sp),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Text("Welcome to Channab", style: poppinTextStyle.copyWith(
                        color: primaryColor,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),),
                      SizedBox(height: 4.h,),
                      Text("Sign up to get started!", style: poppinTextStyle.copyWith(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),),

                      SizedBox(height: 26.h,),

                      InputTextField(
                        hintText: "Full Name",
                        onChanged: (val){
                          model.user.fullName = val;
                          model.updateState();
                        },
                        controller: model.firstNameController,
                      ),


                      SizedBox(height: 23.h,),

                      InputTextField(
                        hintText: "Mobile Number",
                        inputType: TextInputType.phone,
                        onChanged: (val){
                          model.user.mobileNumber = val;
                          model.updateState();
                        },
                        controller: model.mobileNumberController,

                      ),


                      SizedBox(height: 23.h,),




                      InputTextField(
                        hintText: "Email",
                        inputType: TextInputType.emailAddress,
                        onChanged: (val){
                          model.user.email = val;
                          model.updateState();
                        },
                        controller: model.emailController,

                      ),


                      SizedBox(height: 23.h,),


                      InputTextField(
                        hintText: "Password",
                        onChanged: (val){
                          model.user.password = val;
                          model.updateState();
                        },
                        isPasswordActive: !model.isOpen,
                        suffixIcon: InkWell(
                          onTap: (){
                            model.updatePasswordStatus();
                          },
                          child: model.isOpen? Icon(Icons.visibility, color: primaryColor, size: 25.sp,)
                              : Icon(Icons.visibility_off, color: primaryColor, size: 25.sp,),
                        ),
                        controller: model.passwordController,

                      ),

                      SizedBox(height: 23.h,),


                      InputTextField(
                        hintText: "Confirm Password",
                        onChanged: (val){},
                        isPasswordActive: !model.isOpen1,
                        suffixIcon: InkWell(
                          onTap: (){
                            model.updatePasswordStatus1();
                          },
                          child: model.isOpen1? Icon(Icons.visibility, color: primaryColor, size: 25.sp,)
                              : Icon(Icons.visibility_off, color: primaryColor, size: 25.sp,),
                        ),
                        controller: model.confirmPasswordController,

                      ),



                      SizedBox(height: 62.h,),

                      RoundedButton(text: "Sign Up",
                        press: () async {
                        if (_formKey.currentState!.validate()) {
                          await model.registerUserFirsbase();
                          if (model.authResult.status!) {
                            Get.offAll(() =>  HomeScreen());
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Invalid Credential,'),
                                content: Text(
                                    model.authResult.errorMessage ??
                                        'Invalid Credential, Please try again'),
                              ),
                            );
                          }
                        }
                      },),

                      SizedBox(height: 9.h,),
                      Text("or", style: poppinTextStyle.copyWith(
                        color: primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),),
                      SizedBox(height: 9.h,),
                      RoundedButton(text: "Login", press: (){
                        Get.back();

                      },color: lightSilverColor,),



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
}
