import 'package:agri_app/Farmer/home_page.dart';
import 'package:agri_app/WSD_Crops/home_page.dart';
import 'package:agri_app/WSD_Machines/home_page.dart';
import 'package:agri_app/WSD_Seeds/Home_Page.dart';
import 'package:agri_app/widgets/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String val = '';
  bool checkedValue = false;
  bool register = true;
  List textfieldsStrings = [
    "", //firstName
    "", //lastName
    "", //email
    "", //password
    "", //confirmPassword
  ];
  final _firstnamekey = GlobalKey<FormState>();
  final _lastNamekey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;

  //
  // // Get User record using email
  // getUserFromFirebase(String email)async{
  //   try {
  //     return await _firestore
  //         .collection('UsersData')
  //         .where("Email", isEqualTo: email)
  //         .get();
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Registeration
  registerUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Row(
              children: [
                new CircularProgressIndicator(),
                SizedBox(
                  width: 25.0,
                ),
                new Text("Loading, Please wait"),
              ],
            ),
          ),
        );
      },
    );
    try {
      /// Add Data to Firestore
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: textfieldsStrings[2], password: textfieldsStrings[4]);
      User? user = result.user;

      _firestore
          .collection("UsersData")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "FirstName": textfieldsStrings[0],
        "LastName": textfieldsStrings[1],
        "Email": textfieldsStrings[2],
        "Password": textfieldsStrings[3],
        "Role": val,
      }).then((value) {
        _firestore
            .collection(val)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "FirstName": textfieldsStrings[0],
          "LastName": textfieldsStrings[1],
          "Email": textfieldsStrings[2],
          "Password": textfieldsStrings[3],
          "Role": val,
        });
      });
      Navigator.of(context).pop();
      setState(() {
        register = false;
      });
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CustomerLoginScreen(),
      //   ),
      // );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Password Provided is too Weak",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Account Already exists",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }
  // Login
  login(String email,String password)async{

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Row(
              children: [
                new CircularProgressIndicator(),
                SizedBox(
                  width: 25.0,
                ),
                new Text("Loading, Please wait"),
              ],
            ),
          ),
        );
      },
    );

    try {
       await _auth.signInWithEmailAndPassword(
          email: email, password: password);
              QuerySnapshot snapshot = await _firestore
                  .collection('UsersData')
                  .where("Email", isEqualTo: email)
                  .get();
              if(snapshot.docs.length>0){
                     if(snapshot.docs[0]['Role']=="Farmer"){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>FarmerHomePage()));
                     }
                     if(snapshot.docs[0]['Role']=="WSD Seeds"){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SeedsHomePage()));
                     }
                     if(snapshot.docs[0]['Role']=="WSD Crops"){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CropsHomePage()));
                     }
                     if(snapshot.docs[0]['Role']=="WSD Machines"){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MachinesHomePage()));
                     }
                     // return value;
              }
              // return value;


      // User? user = result.user;
      // if (user!.emailVerified) {
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>CustomerHomePage()));
      // }
      // else{
      //   Navigator.of(context).pop();
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       backgroundColor: Colors.orangeAccent,
      //       content: Text(
      //         "Please Verify Your account by clicking on link",
      //         style: TextStyle(fontSize: 18.0, color: Colors.black),
      //       ),
      //     ),
      //   );
      // }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff151f2c) : Colors.white,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Align(
                          child: Row(
                            //TODO: replace text logo with your logo
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Agriculture',
                                style: GoogleFonts.poppins(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: size.height * 0.040,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'App',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff3b22a1),
                                  fontSize: size.height * 0.03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child: Align(
                          child: register
                              ? Text(
                                  'Create an Account',
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xff1D1617),
                                    fontSize: size.height * 0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  'Welcome Back',
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xff1D1617),
                                    fontSize: size.height * 0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                      ),
                      register
                          ? buildTextField(
                              "First Name",
                              Icons.person_outlined,
                              false,
                              size,
                              (valuename) {
                                if (valuename.length <= 2) {
                                  buildSnackError(
                                    'Invalid name',
                                    context,
                                    size,
                                  );
                                  return '';
                                }
                                return null;
                              },
                              _firstnamekey,
                              0,
                              isDarkMode,
                            )
                          : Container(),
                      register
                          ? buildTextField(
                              "Last Name",
                              Icons.person_outlined,
                              false,
                              size,
                              (valuesurname) {
                                if (valuesurname.length <= 2) {
                                  buildSnackError(
                                    'Invalid last name',
                                    context,
                                    size,
                                  );
                                  return '';
                                }
                                return null;
                              },
                              _lastNamekey,
                              1,
                              isDarkMode,
                            )
                          : Container(),
                      Form(
                        child: buildTextField(
                          "Email",
                          Icons.email_outlined,
                          false,
                          size,
                          (valuemail) {
                            if (valuemail.length < 5) {
                              buildSnackError(
                                'Invalid email',
                                context,
                                size,
                              );
                              return '';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                .hasMatch(valuemail)) {
                              buildSnackError(
                                'Invalid email',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          _emailKey,
                          2,
                          isDarkMode,
                        ),
                      ),
                      Form(
                        child: buildTextField(
                          "Passsword",
                          Icons.lock_outline,
                          true,
                          size,
                          (valuepassword) {
                            if (valuepassword.length < 6) {
                              buildSnackError(
                                'Invalid password',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          _passwordKey,
                          3,
                          isDarkMode,
                        ),
                      ),
                      Form(
                        child: register
                            ? buildTextField(
                                "Confirm Passsword",
                                Icons.lock_outline,
                                true,
                                size,
                                (valuepassword) {
                                  if (valuepassword != textfieldsStrings[3]) {
                                    buildSnackError(
                                      'Passwords must match',
                                      context,
                                      size,
                                    );
                                    return '';
                                  }
                                  return null;
                                },
                                _confirmPasswordKey,
                                4,
                                isDarkMode,
                              )
                            : Container(),
                      ),
                      register
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25.0,
                                vertical: 5.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person_outlined,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    val == '' ? 'Select Role' : val,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  DropdownButton<String>(
                                    items: <String>[
                                      'Farmer',
                                      'WSD Seeds',
                                      'WSD Crops',
                                      'WSD Machines',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        val = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 10.0,
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.015,
                          vertical: 0.0,
                        ),
                        child: register
                            ? CheckboxListTile(
                                title: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "By creating an account, you agree to our ",
                                        style: TextStyle(
                                          color: const Color(0xffADA4A5),
                                          fontSize: size.height * 0.015,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: InkWell(
                                          onTap: () {
                                            // ignore: avoid_print
                                            print('Conditions of Use');
                                          },
                                          child: Text(
                                            "Conditions of Use",
                                            style: TextStyle(
                                              color: const Color(0xffADA4A5),
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: size.height * 0.015,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: " and ",
                                        style: TextStyle(
                                          color: const Color(0xffADA4A5),
                                          fontSize: size.height * 0.015,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: InkWell(
                                          onTap: () {
                                            // ignore: avoid_print
                                            print('Privacy Notice');
                                          },
                                          child: Text(
                                            "Privacy Notice",
                                            style: TextStyle(
                                              color: const Color(0xffADA4A5),
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: size.height * 0.015,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                activeColor: const Color(0xff7B6F72),
                                value: checkedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedValue = newValue!;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              )
                            : InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //       const ForgotPasswordPage()),
                                  // );
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Forgot your password?",
                                      style: TextStyle(
                                        color: const Color(0xffADA4A5),
                                        decoration: TextDecoration.underline,
                                        fontSize: size.height * 0.02,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        padding: register
                            ? EdgeInsets.only(top: size.height * 0.025)
                            : EdgeInsets.only(top: size.height * 0.070),
                        child: ButtonWidget(
                          text: register ? "Register" : "Login",
                          backColor: isDarkMode
                              ? [
                                  Colors.black,
                                  Colors.black,
                                ]
                              : const [Colors.black, Colors.green],
                          textColor: const [
                            Colors.white,
                            Colors.white,
                          ],
                          onPressed: () async {
                            if (register) {
                              //validation for register
                              if (_firstnamekey.currentState!.validate()) {
                                if (_lastNamekey.currentState!.validate()) {
                                  if (_emailKey.currentState!.validate()) {
                                    if (_passwordKey.currentState!.validate()) {
                                      if (_confirmPasswordKey.currentState!
                                          .validate()) {
                                        if (val == '') {
                                          buildSnackError('Select your role',
                                              context, size);
                                          // if (checkedValue == false) {
                                          //   buildSnackError(
                                          //       'Accept our Privacy Policy and Term Of Use',
                                          //       context,
                                          //       size);
                                          // } else {
                                          //   print('register');
                                          // }
                                        } else {
                                          if (checkedValue == false) {
                                            buildSnackError(
                                                'Accept our Privacy Policy and Term Of Use',
                                                context,
                                                size);
                                          } else {
                                            print(textfieldsStrings[1]);
                                            print('register');
                                            registerUser();
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            } else {
                              //validation for login
                              if (_emailKey.currentState!.validate()) {
                                if (_passwordKey.currentState!.validate()) {
                                  print('login');
                                  login(textfieldsStrings[2],textfieldsStrings[3]);
                                }
                              }
                            }
                          },
                        ),
                      ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        padding: EdgeInsets.only(
                          top: register
                              ? size.height * 0.025
                              : size.height * 0.15,
                        ),
                        child: Row(
                          //TODO: replace text logo with your logo
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: size.height * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '+',
                              style: GoogleFonts.poppins(
                                color: const Color(0xff3b22a1),
                                fontSize: size.height * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: register
                                  ? "Already have an account? "
                                  : "Don’t have an account yet? ",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color(0xff1D1617),
                                fontSize: size.height * 0.018,
                              ),
                            ),
                            WidgetSpan(
                              child: InkWell(
                                onTap: () => setState(() {
                                  if (register) {
                                    register = false;
                                  } else {
                                    register = true;
                                  }
                                }),
                                child: register
                                    ? Text(
                                        "Login",
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..shader = const LinearGradient(
                                              colors: <Color>[
                                                Color(0xffEEA4CE),
                                                Color(0xffC58BF2),
                                              ],
                                            ).createShader(
                                              const Rect.fromLTWH(
                                                0.0,
                                                0.0,
                                                200.0,
                                                70.0,
                                              ),
                                            ),
                                          fontSize: size.height * 0.018,
                                        ),
                                      )
                                    : Text(
                                        "Register",
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..shader = const LinearGradient(
                                              colors: <Color>[
                                                Color(0xffEEA4CE),
                                                Color(0xffC58BF2),
                                              ],
                                            ).createShader(
                                              const Rect.fromLTWH(
                                                  0.0, 0.0, 200.0, 70.0),
                                            ),
                                          // color: const Color(0xffC58BF2),
                                          fontSize: size.height * 0.018,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool pwVisible = false;

  Widget buildTextField(
    String hintText,
    IconData icon,
    bool password,
    size,
    FormFieldValidator validator,
    Key key,
    int stringToEdit,
    bool isDarkMode,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : const Color(0xffF7F8F8),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: TextFormField(
            style: TextStyle(
                color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
            onChanged: (value) {
              setState(() {
                textfieldsStrings[stringToEdit] = value;
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.012,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
              suffixIcon: password
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pwVisible = !pwVisible;
                          });
                        },
                        child: pwVisible
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: Color(0xff7B6F72),
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                color: Color(0xff7B6F72),
                              ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context, size) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }
}
