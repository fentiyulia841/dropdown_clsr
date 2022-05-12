import 'package:flutter/material.dart';
import 'package:dropdwon_clsr/models/user_model.dart';
import 'package:dropdwon_clsr/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dropdwon_clsr/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCasePage extends StatefulWidget {
  const NewCasePage({Key? key}) : super(key: key);

  @override
  State<NewCasePage> createState() => _NewCasePageState();
}

class _NewCasePageState extends State<NewCasePage> {
  
  final UserBloc _userBloc = UserBloc();
  final UserModel usermodel = UserModel();
  String? selectedValue = "Leanne Graham";
  List<UserModel> listModel = [];

  @override
  void initState() {
    _userBloc.add(GetUserList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: buttonColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Case Data',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildListWilayah() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              // margin: EdgeInsets.only(top: 20),
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: textFieldColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: BlocProvider(
                        create: (_) => _userBloc,
                        child: BlocListener<UserBloc, UserState>(
                          listener: (context, state) {
                            if (state is UserError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message!),
                                ),
                              );
                            }
                          },
                          child: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserInitial) {
                                return _buildLoading();
                              } else if (state is UserLoading) {
                                return _buildLoading();
                              } else if (state is UserLoaded) {
                                print(state.userModel);
                                return _buildCard(context, state.userModel);
                              } else if (state is UserError) {
                                return Container();
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget submitButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30.0),
        child: TextButton(
          // on press route menuju page home
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          style: TextButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Text(
            'Submit',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Copy Right ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/sign-up');
              },
              child: Text(
                'Team Performance',
                style: orangeSubtitleColorStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),

                _buildListWilayah(),

                submitButton(),
                // spacer -> widget yang memberi ruang antara body content dan footer

                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, UserModel model) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var i = 0; i < listModel.length; i++) {
      menuItems.add(
        DropdownMenuItem(
          child: Text(
            "${model.name}",
          ),
          value: "${model.name}",
        ),
      );
    }

    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      print(selectedValue);
                      print(menuItems);
                      selectedValue = newValue!;
                    });
                  },
                  items: menuItems,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
