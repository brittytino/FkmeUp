import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientProvider {
  const SupabaseClientProvider();

  SupabaseClient? get client {
    try {
      return Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }
}
