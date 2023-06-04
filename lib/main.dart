import 'package:bus_owner/Provider/NavProvider.dart';
import 'package:bus_owner/Screens/HomePage.dart';
import 'package:bus_owner/Screens/MyBusesPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
   await Supabase.initialize(
    url: 'https://ogwbsawdfrfragnjwrhu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9nd2JzYXdkZnJmcmFnbmp3cmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI2MTIxNzcsImV4cCI6MTk5ODE4ODE3N30.K-QINUpml_pmIyvgsWZfmEC_RtfW-t7Ewz8v-SCbvqg',
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>NavProvider(),),
   
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColorLight: Colors.white
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> screen = [HomPage(), MyBusesPage()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,leading: Icon(Icons.arrow_back),foregroundColor: Colors.black,title:Text( currentIndex==0?"Home ":"My buses")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        
        onTap: (value){setState(() {
          currentIndex=value;
          print(currentIndex);
        });},
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"), BottomNavigationBarItem(icon: Icon(Icons.bus_alert), label: "My Buses")]),
      body: screen[currentIndex]
    );
  }
}
