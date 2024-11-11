import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/auth_provider.dart';
import 'package:tofu/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    AuthProvider authProvider = Provider.of(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) {
      authProvider.isAuthenticated
          ? Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false)
          : Navigator.pushNamedAndRemoveUntil(
              context, '/landing', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/tofu.png'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
