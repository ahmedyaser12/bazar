import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

//
//   Future<UserCredential> signUp(String email, String password) async {
//     return await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email, password: password);
//   }
//
//   Future<UserCredential> signIn(String email, String password) async {
//     return await _firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//   }
//
//   User? getCurrentUser() {
//     return _firebaseAuth.currentUser;
//   }

  Future<void> addToCart(String userId, Map<String, dynamic> newItem) async {
    var cartRef = FirebaseFirestore.instance.collection('carts').doc(userId);

    // Transaction to ensure atomic operation
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      var cartSnapshot = await transaction.get(cartRef);
      // Check if the document exists
      if (!cartSnapshot.exists) {
        // If the cart doesn't exist, create a new cart document with the item
        transaction.set(cartRef, {
          'cartItems': [newItem]
        });
      } else {
        // The cart exists
        var cartData = cartSnapshot.data() as Map<String, dynamic>;
        var currentCartItems = cartData['cartItems'] != null
            ? List.from(cartData['cartItems'])
            : [];

        int existingItemIndex =
            currentCartItems.indexWhere((item) => item['id'] == newItem['id']);

        if (existingItemIndex >= 0) {
          // If the item exists, update the quantity
          currentCartItems[existingItemIndex]['num'] = newItem['num'];
          currentCartItems[existingItemIndex]['price'] = newItem['price'];
        } else {
          // If the item doesn't exist, add the new item
          currentCartItems.add(newItem);
        }

        transaction.update(cartRef, {'cartItems': currentCartItems});
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCartItems(String userId) async {
    var cartRef = _db.collection('carts').doc(userId);

    var cartSnapshot = await cartRef.get();
    if (cartSnapshot.exists) {
      var cartData = cartSnapshot.data() as Map<String, dynamic>;
      return List<Map<String, dynamic>>.from(cartData['cartItems'] ?? []);
    } else {
      // Cart document doesn't exist, return an empty list
      return [];
    }
  }

  Future<List> removeFromCart(String userId, int itemId) async {
    var cartRef = _db.collection('carts').doc(userId);
    var cartSnapshot = await cartRef.get();
    if (cartSnapshot.exists) {
      var cartData = cartSnapshot.data() as Map<String, dynamic>;
      var currentCartItems =
          cartData['cartItems'] != null ? List.from(cartData['cartItems']) : [];
      int index = currentCartItems.indexWhere((item) => item['id'] == itemId);
      if (index >= 0) {
        currentCartItems.removeAt(index);
        cartRef.update({'cartItems': currentCartItems});
        return currentCartItems;
      }
    }
    return [];
  }
}

// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleAuthHelper {
//   /// Handle Google Signin to authenticate user
//   Future<GoogleSignInAccount?> googleSignInProcess() async {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//     if (googleUser != null) {
//       return googleUser;
//     }
//     return null;
//   }
//
//   /// To Check if the user is already signedin through google
//   alreadySignIn() async {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     bool alreadySignIn = await googleSignIn.isSignedIn();
//     return alreadySignIn;
//   }
//
//   /// To signout from the application if the user is signed in through google
//   Future<GoogleSignInAccount?> googleSignOutProcess() async {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     GoogleSignInAccount? googleUser = await googleSignIn.signOut();
//
//     return googleUser;
//   }
// }
