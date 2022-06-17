
import 'package:flutter/cupertino.dart';

import '../../../../core/enums/view_state.dart';
import '../../../../core/models/app_user.dart';
import '../../../../core/models/custom_auth_result.dart';
import '../../../../core/services/auth_services.dart';
import '../../../../core/services/database_services.dart';
import '../../../../core/view_model/base_view_model.dart';
import '../../../../locator.dart';

class SignUpViewModel extends BaseViewModel{
  bool isOpen = true;
  bool isOpen1 = true;


  AppUser user = AppUser();

  final dbServices = DatabaseService();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _authService = locator<AuthService>();
  late CustomAuthResult authResult;



  updateState(){
    setState(ViewState.busy);
    setState(ViewState.idle);
  }


  updatePasswordStatus(){
    setState(ViewState.busy);
    isOpen = !isOpen;
    setState(ViewState.idle);
  }

  updatePasswordStatus1(){
    setState(ViewState.busy);
    isOpen1 = !isOpen1;
    setState(ViewState.idle);
  }




  registerUserFirsbase() async{
    setState(ViewState.loading);
    try{
//      print(user.toJson());
      authResult = await _authService.signUpWithEmailPassword(user);

    }catch(e,s){
      debugPrint("registerUser EXCEPTION $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }




}