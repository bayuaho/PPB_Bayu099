// lib/main.dart

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A3A6B)),
        useMaterial3: true,
      ),
      home: const PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Header / AppBar ──────────────────────────────────────────────
          Container(
            color: const Color(0xFF1A3A6B),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.menu, color: Colors.white),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'PAYMENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),

          // ── Balance Section ──────────────────────────────────────────────
          Container(
            width: double.infinity,
            color: const Color(0xFF1A3A6B),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white38, width: 2),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'BALANCE',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$4,180.20',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Grid Menu ───────────────────────────────────────────────────
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: Column(
                  children: [
                    // Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _PaymentItem(
                          icon: Icons.water_drop,
                          label: 'Water',
                          bgColor: const Color(0xFF29B6F6),
                        ),
                        _PaymentItem(
                          icon: Icons.lightbulb,
                          label: 'Electricity',
                          bgColor: const Color(0xFFFFA726),
                        ),
                        _PaymentItem(
                          icon: Icons.local_fire_department,
                          label: 'Gas',
                          bgColor: const Color(0xFFEF5350),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _PaymentItem(
                          icon: Icons.shopping_bag,
                          label: 'Shopping',
                          bgColor: const Color(0xFFEC407A),
                        ),
                        _PaymentItem(
                          icon: Icons.phone_android,
                          label: 'Phone',
                          bgColor: const Color(0xFF1A3A6B),
                        ),
                        _PaymentItem(
                          icon: Icons.credit_card,
                          label: 'Credit Card',
                          bgColor: const Color(0xFF26A69A),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Row 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _PaymentItem(
                          icon: Icons.shield,
                          label: 'Insurance',
                          bgColor: const Color(0xFF26A69A),
                        ),
                        _PaymentItem(
                          icon: Icons.home,
                          label: 'Mortgage',
                          bgColor: const Color(0xFF1A3A6B),
                        ),
                        _PaymentItem(
                          icon: Icons.receipt_long,
                          label: 'Other Bills',
                          bgColor: const Color(0xFF546E7A),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // More link
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'more >>',
                        style: TextStyle(color: Colors.blue[700], fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable Payment Item Widget ─────────────────────────────────────────────
class _PaymentItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;

  const _PaymentItem({
    required this.icon,
    required this.label,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}
