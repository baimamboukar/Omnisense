import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omnisense/src/configs/configs.dart';
import 'package:omnisense/src/features/auth/auth.dart';
import 'package:twitter_login_v2/twitter_login_v2.dart' as v2;

class OmnisenseAuthServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreAuthServices _firestoreAuthServices = FirestoreAuthServices();
  Future<OmnisenseUser> continueWithTwitter() async {
    try {
      final twitterLogin = v2.TwitterLoginV2(
        clientId: dotenv.get('TWITTER_CLIENT_ID'),

        /// Consumer API keys
        redirectURI: 'https://omnisense-ai.firebaseapp.com/__/auth/handler',

        /// Registered Callback URLs in TwitterApp
        scopes: [
          'tweet.read',
          'follows.read',
        ],
      );

      final accessToken = await twitterLogin.loginV2();
      if (accessToken.accessToken != null) {
        final AuthCredential credential = TwitterAuthProvider.credential(
          accessToken: accessToken.accessToken!,
          secret: dotenv.get('TWITTER_API_SECRET'),
        );
        final userCredential = await _auth.signInWithCredential(
          credential,
        );
        // Store additional user data to Firestore if user does not exist
        final user = userCredential.user;
        final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        if (!userSnapshot.exists) {
          final omnisenseUser = OmnisenseUser(
            id: user.uid,
            name: user.displayName!,
            email: user.email!,
            phone: user.displayName ?? '',
            profileImageURL:
                user.photoURL ?? OmnisenseConstants.PROFILE_IMAGE_URL,
            isPrenium: false,
          );
          final saved = await _firestoreAuthServices
              .saveUserDataToFirestore(omnisenseUser);
          if (saved) {
            return omnisenseUser;
          } else {
            throw Exception('The user information could not be saved');
          }
        } else {
          throw Exception('The twitter user already exists');
        }
      } else {
        throw Exception('The twitter user could not be authenticated');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<OmnisenseUser> signUpWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuth = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      // Store additional user data to Firestore if user does not exist
      final user = userCredential.user;
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (!userSnapshot.exists) {
        final omnisenseUser = OmnisenseUser(
          id: user.uid,
          name: user.displayName!,
          email: user.email!,
          phone: user.displayName ?? '',
          profileImageURL:
              user.photoURL ?? OmnisenseConstants.PROFILE_IMAGE_URL,
          isPrenium: false,
        );
        final saved =
            await _firestoreAuthServices.saveUserDataToFirestore(omnisenseUser);
        if (saved) {
          return omnisenseUser;
        } else {
          throw Exception('The user information could not be saved');
        }
      } else {
        throw Exception('The user already exists');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<OmnisenseUser> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuth = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      // Store additional user data to Firestore
      final user = userCredential.user;
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (!userSnapshot.exists) {
        final omnisenseUser = OmnisenseUser(
          id: user.uid,
          name: user.displayName!,
          email: user.email!,
          phone: user.displayName ?? '',
          profileImageURL:
              user.photoURL ?? OmnisenseConstants.PROFILE_IMAGE_URL,
          isPrenium: false,
        );
        final saved =
            await _firestoreAuthServices.saveUserDataToFirestore(omnisenseUser);
        if (saved) {
          return omnisenseUser;
        } else {
          throw Exception('The user information could not be saved');
        }
      } else {
        final omnisenseUser =
            _firestoreAuthServices.getUserDataFromFirestore(user.uid);
        return omnisenseUser;
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
