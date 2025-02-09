import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SenderProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Map<String, dynamic>? sender;


// Fetch sender details
  Future<void> fetchSender() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        print('eamil of user isssssssssssssss');
        print(currentUser.email);
        final response = await supabase
            .from('users')
            .select('*')
            .eq('email', currentUser.email!)
            .single();
        print('response of fetch sender issssssssss');
        print(response);
        sender = response;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching sender: $e');
    }
  }


}
