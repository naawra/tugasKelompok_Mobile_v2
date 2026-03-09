import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../app/routes/app_routes.dart';
import '../../app/theme/app_theme.dart';

class _MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String route;

  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.route,
  });
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static final _menus = [
    const _MenuItem(
      title: 'Profile Kelompok',
      subtitle: 'Informasi anggota kelompok',
      icon: Icons.group_outlined,
      gradient: [AppColors.navy, AppColors.charcoal],
      route: AppRoutes.PROFILE,
    ),
    const _MenuItem(
      title: 'Penjumlahan & Pengurangan',
      subtitle: 'Operasi aritmatika dasar',
      icon: Icons.calculate_outlined,
      gradient: [AppColors.deepBlue, AppColors.blue],
      route: AppRoutes.ARITHMETIC,
    ),
    const _MenuItem(
      title: 'Ganjil, Genap & Prima',
      subtitle: 'Cek jenis bilangan',
      icon: Icons.numbers_outlined,
      gradient: [AppColors.blue, AppColors.slate],
      route: AppRoutes.ODD_EVEN_PRIME,
    ),
    const _MenuItem(
      title: 'Hitung Karakter',
      subtitle: 'Breakdown jumlah karakter teks',
      icon: Icons.text_fields_rounded,
      gradient: [AppColors.charcoal, AppColors.navy],
      route: AppRoutes.CHAR_COUNTER,
    ),
    const _MenuItem(
      title: 'Stopwatch',
      subtitle: 'Timer dengan fitur lap & split',
      icon: Icons.timer_outlined,
      gradient: [Color(0xFF1A3A6B), AppColors.deepBlue],
      route: AppRoutes.STOPWATCH,
    ),
    const _MenuItem(
      title: 'Luas & Volume Piramid',
      subtitle: 'Kalkulasi piramid segiempat',
      icon: Icons.change_history_outlined,
      gradient: [Color(0xFF3A3250), AppColors.charcoal],
      route: AppRoutes.PYRAMID,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 130,
            pinned: true,
            backgroundColor: AppColors.navy,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(color: Colors.blueGrey),
                child: const Stack(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Menu Utama',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Pilih fitur yang ingin digunakan',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white60,
                              ),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined, color: Colors.white),
                tooltip: 'Logout',
                onPressed: () => _confirmLogout(context),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _MenuListTile(
                  item: _menus[index],
                  index: index,
                ),
                childCount: _menus.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Konfirmasi Logout',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal',
                style: TextStyle(color: AppColors.charcoal)),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              Get.find<AuthController>().logout();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Logout',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _MenuListTile extends StatelessWidget {
  final _MenuItem item;
  final int index;

  const _MenuListTile({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Get.toNamed(item.route),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.deepBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSub,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.slate,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
