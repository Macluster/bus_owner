import 'package:bus_owner/Provider/NavProvider.dart';
import 'package:bus_owner/Screens/HomePage.dart';
import 'package:bus_owner/Screens/MyBusesPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Backend/SupabaseAuthentication.dart';
import 'Backend/SupabaseDatabase.dart';
import 'Provider/UserProvider.dart';
import 'Screens/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://ogwbsawdfrfragnjwrhu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9nd2JzYXdkZnJmcmFnbmp3cmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI2MTIxNzcsImV4cCI6MTk5ODE4ODE3N30.K-QINUpml_pmIyvgsWZfmEC_RtfW-t7Ewz8v-SCbvqg',
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => NavProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColorLight: Color.fromARGB(255, 245, 241, 241),
          primaryColor: Colors.black),
      home: LoginCheck(),
    );
  }
}

class LoginCheck extends StatefulWidget {
  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  @override
  Widget build(BuildContext context) {
    return Supabase.instance.client.auth.currentUser != null
        ? MyHomePage(title: "")
        : LoginPage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> screen = [HomPage(), MyBusesPage()];

  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    setuserId();
  }

  setuserId() async {
    var id = await SupaBaseDatabase().getCurrentUserId();

    context.read<UserProvider>().setCurrentUserId(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColorLight,
          leading: Icon(Icons.arrow_back),
          foregroundColor: Theme.of(context).primaryColor,
          title: Text(currentIndex == 0 ? "Home " : "My buses"),
          actions: [
            TextButton(
                onPressed: () {
                  SupabaseAuthentication().SignOut();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text("Sign out"))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
                print(currentIndex);
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bus_alert), label: "My Buses")
            ]),
        body: screen[currentIndex]);
  }
}
