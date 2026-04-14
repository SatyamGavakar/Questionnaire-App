import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/features/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0F172A),
              colors.primary.withValues(alpha: 0.82),
              const Color(0xFF1E293B),
            ],
          ),
        ),
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.96, end: 1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 108,
                  height: 108,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.28),
                      width: 1.2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 22,
                        offset: Offset(0, 14),
                        color: Color(0x33000000),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    size: 54,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  'Questionnaire App',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        letterSpacing: 0.2,
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 28),
                
                Text(
                  ' Developed by Satyam Gavkar',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                ),
                const SizedBox(height: 20),
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}
