import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tai_learner/ui/pages/landing_page/landing_page.dart';
import 'package:tai_learner/ui/pages/unit/bloc/unit_bloc.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
    // await Firebase.initializeApp();
    runApp(MultiBlocProvider(providers: [
      BlocProvider<UnitBloc>(
        create: (BuildContext context) => di.sl<UnitBloc>(),
      ),
      // BlocProvider<TableBloc>(
      //   create: (BuildContext context) => di.sl<TableBloc>(),
      // ),
    ], child:const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavigationBarWidget(),
    );
  }
}
class NavigationBarWidget extends StatefulWidget{
  const NavigationBarWidget({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationBarWidgetState();

}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const LandingPage(),
    const LandingPage(),
    const LandingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
           BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            activeIcon: Icon(Icons.home,color: Colors.green,),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person,color: Colors.green,),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings,color: Colors.green,),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}