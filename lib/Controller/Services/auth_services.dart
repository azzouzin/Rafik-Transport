import 'dart:ffi';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rafik/View/Authpages/OTP/register.dart';
import 'package:rafik/View/Authpages/signuppage.dart';

import '../../Model/driver.dart';
import '../../Model/user.dart';
import '../../View/Authpages/contractpage.dart';
import '../../View/Compenents/theme.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    print(email);
    print(password);
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      print("Signed in seccsecfully ${user!.displayName}");
      print("Signed in seccsecfully ${user.email}");
      print("Signed in seccsecfully ${user.photoURL}");
      print("Signed in seccsecfully ${user.uid}");

      // Handle successful login
      return user.uid;
    } catch (e) {
      // Handle login error
      print(e.toString());
      return null;
    }
  }

  Future<String> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
        // Handle successful login

        print("Signed in seccsecfully ${googleSignInAccount!.displayName}");
        print("Signed in seccsecfully ${googleSignInAccount!.email}");
        print("Signed in seccsecfully ${googleSignInAccount!.photoUrl}");
      }
      return 'ok';
    } catch (e) {
      // Handle login error
      return e.toString();
    }
  }

  Future<AppUser?> registerUser({
    required String password,
    required String name,
    required String phone,
    required String email,
  }) async {
    print('email = $email');
    print('password = $password');
    print('phone = $phone');
    print('name = $name');
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Registration successful, you can access the newly registered user from userCredential.user
      User? user = userCredential.user;

      if (user != null) {
        // User registration successful, perform any additional tasks
        print('User registration successful. User ID: ${user.uid}');

        try {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(AppUser(
                      email: email,
                      isDriver: false,
                      name: name,
                      phone: phone,
                      uid: user.uid,
                      image:
                          'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=826&t=st=1696860037~exp=1696860637~hmac=dbabaf9c995171e8af299c1130d45748b44242560cf027dcf5a079e51b5ae156')
                  .toMap())
              .then((value) async {
            AppUser? appUser = await getuserdata(user.uid);

            Get.snackbar('Congartilations',
                'Your Account was created you can log in now',
                backgroundColor: green);
            Get.toNamed("/signup");
            return appUser;
          }).catchError((e) {
            print('Creat user error : $e');
            Get.snackbar('Error', e.toString(),
                backgroundColor: pink, colorText: white);
            return null;
          });
        } catch (e) {
          Get.snackbar('Error', e.toString(),
              backgroundColor: pink, colorText: white);
          print('Creat User error: $e');
          return null;
        }
      } else {
        // User registration failed
        Get.snackbar('Error', 'User registration failed.',
            backgroundColor: pink, colorText: white);
        print('User registration failed.');
        return null;
      }
    } catch (e) {
      // Registration failed
      Get.snackbar('Error', e.toString(),
          backgroundColor: pink, colorText: white);
      return null;
    }
  }

  Future<Driver?> registerDriverWithEmailAndPassword(
      {required String password,
      required String carModele,
      required String name,
      required String phone,
      email}) async {
    print('EMAIL = $email');
    print('password = $password');
    print('car modele = $carModele');
    print('name = $name');
    print('phone = $phone');
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Registration successful, you can access the newly registered user from userCredential.user
      User? user = userCredential.user;

      if (user != null) {
        // User registration successful, perform any additional tasks
        print('User registration successful. User ID: ${user.uid}');
        print(phone);
        try {
          FirebaseFirestore.instance
              .collection('drivers')
              .doc(user.uid)
              .set(Driver(
                isDriver: true,
                phone: phone,
                email: email,
                rating: '1',
                name: name,
                carmodele: carModele,
                uid: user.uid,
                image:
                    'https://img.freepik.com/free-psd/cool-man-3d-cartoon-avatar-portrait_627936-37.jpg?w=740&t=st=1696675512~exp=1696676112~hmac=437b98ff2d389a5401edec3e26682ae4a973fbd248937490d25b66bed5700283',
              ).toMap())
              .then((value) async {
            print("Driver resgistred");
            // appUser = await getuserdata(appUser!);
            Get.snackbar('Congartilations',
                'Your Account was created you can log in now',
                backgroundColor: green);

            //  Get.to(DownloadContract());

            return Driver(
              isDriver: true,
              phone: phone,
              email: email,
              rating: '1',
              name: name,
              carmodele: carModele,
              uid: user.uid,
              image:
                  'https://img.freepik.com/free-psd/cool-man-3d-cartoon-avatar-portrait_627936-37.jpg?w=740&t=st=1696675512~exp=1696676112~hmac=437b98ff2d389a5401edec3e26682ae4a973fbd248937490d25b66bed5700283',
            );
          }).catchError((e) {
            Get.snackbar('Error', e.toString(),
                backgroundColor: pink, colorText: white);
            print('Creat user error : $e');
            null;
          });
        } catch (e) {
          Get.snackbar('Error', e.toString(),
              backgroundColor: pink, colorText: white);
          print('Registration error: $e');
          return null;
        }
      } else {
        // User registration failed

        Get.snackbar('Error', 'User registration failed.',
            backgroundColor: pink, colorText: white);
        print('User registration failed.');
        return null;
      }
    } catch (e) {
      // Registration failed

      Get.snackbar('Error', e.toString(),
          backgroundColor: pink, colorText: white);
      print('Registration error: $e');
      return null;
    }
  }

  Future<String> logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      // Log out successful
      print('User logged out successfully.');
      return 'ok';
    } catch (e) {
      // Log out failed
      print('Logout error: $e');
      return e.toString();
    }
  }

  Future<AppUser?> getuserdata(uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (!snapshot.exists) {
      print('Document does not exist');
      return null;
    }

    Object data = snapshot.data()!;

    AppUser appUser = AppUser.fromMap(data as Map<String, dynamic>);

    print(appUser.name);

    // ...

    return appUser;
  }

  Future<Driver?> getDriverData(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('drivers').doc(uid).get();

    if (!snapshot.exists) {
      print('Document does not exist');
      return null;
    }

    Object data = snapshot.data()!;
    log(data.toString());
    Driver driver = Driver.fromMap(data as Map<String, dynamic>);

    print(driver.name);
    print(driver.carmodele);
    // ...

    return driver;
  }
}

  /*Future<String> registerWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
        // Handle successful registration

        if (_googleSignIn.isSignedIn() == true) {
          print(
              "Registred in seccsecfully ${googleSignInAccount!.displayName}");
          print("Registred in seccsecfully ${googleSignInAccount!.email}");
          print("Registred in seccsecfully ${googleSignInAccount!.photoUrl}");

          await creatuser(
              AppUser(
                  email: googleSignInAccount.email,
                  image: googleSignInAccount.photoUrl,
                  name: googleSignInAccount.displayName,
                  phone: '+210 54823321',
                  uid: googleSignInAccount.id),
              false);
        }
        return 'ok';
      } else {
        return 'Unkown Error';
      }
    } catch (e) {
      print('Thee is an ERROR = ' + e.toString());
      return e.toString();
    }
  }
*/
 

