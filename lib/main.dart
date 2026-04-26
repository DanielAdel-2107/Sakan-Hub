import 'package:flutter/material.dart';
import 'package:sakan/app/my_app.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://yrqpmunjjmhuqtowylem.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlycXBtdW5qam1odXF0b3d5bGVtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA1Mzc2ODcsImV4cCI6MjA4NjExMzY4N30._fBT9fbMaEs4Rn5XRNKijtWZDCtmKYx_j4c9pGnj7lI",
  );
  await setupDI();
  runApp(const MyApp());
}
