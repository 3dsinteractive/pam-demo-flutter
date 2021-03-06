import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:pam_flutter/types.dart';
import 'package:pam_flutter/utils/requester.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/shared_preferences.dart';
import 'package:singh_architecture/models/authentication_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/locale_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/utils/time_helper.dart';
import 'package:singh_architecture/widgets/commons/primary_button.dart';
import 'package:singh_architecture/widgets/dialog_tree.dart';

class AuthenticationRepository extends BaseDataRepository {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;
  final ISharedPreferences sharedPreferences;

  late List<String> favouriteProductIds;
  LoginResponseModel? loginData;
  RegisterResponseModel? registerData;

  AuthenticationRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
    required this.sharedPreferences,
  }) : super(buildCtx, config, options, sharedPreferences) {
    this.favouriteProductIds = List<String>.empty(growable: true);
  }

  bool get isAuth {
    String? token =
        this.sharedPreferences.getAuthentication()?["authorization"];
    return token != null && token != "";
  }

  bool get isNotAuth {
    return !this.isAuth;
  }

  bool isProductFavourite(String id) {
    return this.favouriteProductIds.contains(id);
  }

  Future<void> mockFavourite(String id) async {
    try {
      this.toLoadingStatus();

      await TimeHelper.sleep();
      this.favouriteProductIds.add(id);

      Pam.trackFavourite(
        id: id,
      );

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> mockUnFavourite(String id) async {
    try {
      this.toLoadingStatus();

      await TimeHelper.sleep();
      this.favouriteProductIds.removeWhere((pId) => id == pId);

      Pam.trackUnFavourite(
        id: id,
      );

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      Response response =
          await Requester.post("${this.config.baseAPI()}/login", {
        "email": email,
        "password": password,
      });
      Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
      data = js;

      this.loginData = LoginResponseModel.fromJson(data["data"]);
      await this
          .sharedPreferences
          .setAuthentication(token: "token12345678", others: {
        "customer": this.loginData?.CustomerId ?? "invalid",
      });
      await Pam.userLogin(this.loginData?.CustomerId ?? "invalid");

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> mockLogin() async {
    try {
      this.toLoadingStatus();

      await TimeHelper.sleep();
      await this
          .sharedPreferences
          .setAuthentication(token: "token12345678", others: {
        "customer": "a",
      });
      await Pam.userLogin("a");

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> register(
    String email,
    String password, {
    List<String>? consentIds,
  }) async {
    try {
      this.toLoadingStatus();
      late Map<String, dynamic> data;

      Response response =
          await Requester.post("${this.config.baseAPI()}/register", {
        "email": email,
        "password": password,
        "consent_ids": (consentIds ?? []).join(","),
      });
      Map<String, dynamic> js = json.decode(utf8.decode(response.bodyBytes));
      data = js;

      this.registerData = RegisterResponseModel.fromJson(data["data"]);
      await this
          .sharedPreferences
          .setAuthentication(token: "token12345678", others: {
        "customer": this.registerData?.CustomerId ?? "invalid",
      });
      await Pam.userLogin(this.registerData?.CustomerId ?? "invalid");

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> mockLogout() async {
    try {
      this.toLoadingStatus();

      await TimeHelper.sleep();
      this.sharedPreferences.removeAuthentication();
      await Pam.userLogout();

      this.toLoadedStatus();
    } catch (e) {
      this.alertError(e);
      this.toErrorStatus(e);
    }
  }

  Future<void> showDialogLogin({
    required LocaleRepository localeRepository,
    void Function()? callbackSuccess,
    void Function()? onRegisterClick,
  }) async {
    DialogTree.show(
      this.buildCtx,
      (dismiss) {
        TextEditingController emailText = TextEditingController();
        TextEditingController passwordText = TextEditingController();

        final formKey = GlobalKey<FormState>();

        return Container(
          width: MediaQuery.of(this.buildCtx).size.width,
          height: MediaQuery.of(this.buildCtx).size.height,
          color: Colors.black26,
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              child: Container(
                padding: EdgeInsets.all(16),
                height: 609,
                color: Colors.white,
                width: MediaQuery.of(this.buildCtx).size.width - 32,
                child: StreamBuilder(
                  stream: this.isLoadingSC.stream,
                  builder: (context, snapshot) {
                    return Stack(
                      children: [
                        Form(
                          key: formKey,
                          child: ListView(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    dismiss();
                                  },
                                  child: Icon(Icons.close),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  top: 16,
                                  bottom: 32,
                                ),
                                child: Text(
                                  localeRepository.getString("login_required"),
                                  style: TextStyle(
                                    fontSize: h3,
                                    fontWeight: fontWeightBold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 16,
                                  left: 24,
                                  right: 24,
                                ),
                                child: TextFormField(
                                  controller: emailText,
                                  validator: (v) {
                                    if (v == null || v == "") {
                                      return "This field is require";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: localeRepository
                                        .getString("email_placeholder"),
                                    errorStyle: TextStyle(
                                        height: 0, color: Colors.transparent),
                                    prefixIcon: Icon(Icons.email_outlined),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorGray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorGray,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorGray,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorGray,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        top: 12,
                                        bottom: 12,
                                        left: 16,
                                        right: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 8,
                                  left: 24,
                                  right: 24,
                                ),
                                child: TextFormField(
                                  validator: (v) {
                                    if (v == null || v == "") {
                                      return "This field is require";
                                    }

                                    return null;
                                  },
                                  controller: passwordText,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: localeRepository
                                        .getString("password_placeholder"),
                                    errorStyle: TextStyle(
                                        height: 0, color: Colors.transparent),
                                    prefixIcon: Icon(Icons.vpn_key_outlined),
                                    // errorStyle: TextStyle(height: 0),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorGray,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorGray,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorGray,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: colorGray,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        top: 12,
                                        bottom: 12,
                                        left: 16,
                                        right: 16),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  bottom: 32,
                                ),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  localeRepository.getString("forgot_password"),
                                  style: TextStyle(
                                    color: colorSecondary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              PrimaryButton(
                                margin: EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                ),
                                onClick: () async {
                                  if (formKey.currentState?.validate() ==
                                      true) {
                                    await login(
                                        emailText.text, passwordText.text);
                                    if (!this.isError) {
                                      callbackSuccess?.call();
                                      dismiss();
                                    }
                                  }
                                },
                                title: localeRepository.getString("login"),
                                width: double.infinity,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 16,
                                      ),
                                      child: Text(
                                        localeRepository
                                            .getString("new_member"),
                                        style: TextStyle(
                                          color: colorGrayDark,
                                          fontSize: h6,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        onRegisterClick?.call();
                                      },
                                      child: Container(
                                        child: Text(
                                          localeRepository
                                              .getString("register_here"),
                                          style: TextStyle(
                                            color: colorPrimary,
                                            fontSize: p,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 16,
                                  bottom: 16,
                                  left: 24,
                                  right: 24,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: 1,
                                      color: colorGrayLight,
                                    )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                      ),
                                      child: Text(
                                        localeRepository.getString("or"),
                                        style: TextStyle(
                                          height: 1,
                                          fontSize: p,
                                          color: colorGrayDark,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: 1,
                                      color: colorGrayLight,
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 16,
                                  bottom: 16,
                                  left: 24,
                                  right: 24,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              margin: EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: Image.asset(
                                                          "lib/statics/google.png")
                                                      .image,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                localeRepository.getString(
                                                    "login_with_google"),
                                                style: TextStyle(
                                                  color: colorGrayDark,
                                                  fontSize: s2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              margin: EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: Image.asset(
                                                          "lib/statics/facebook.png")
                                                      .image,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                localeRepository.getString(
                                                    "login_with_facebook"),
                                                style: TextStyle(
                                                  color: colorGrayDark,
                                                  fontSize: s2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IgnorePointer(
                          ignoring: snapshot.data == false,
                          child: snapshot.data == true
                              ? Container(
                                  alignment: Alignment.center,
                                  color: Colors.white.withOpacity(0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: colorGray, blurRadius: 2)
                                        ]),
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(
                                              colorSecondary,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(localeRepository
                                              .getString("loading")),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
