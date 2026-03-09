import 'package:flutter/material.dart';
import '../../models/group_member_model.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/app_widgets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String namaKelompok  = 'Kelompok AAD3A';
  static const String mataKuliah    = 'Teknologi dan Pemrograman Mobile';
  static const String semester      = 'Semester 6';
  static const String tahunAjaran   = '2025 / 2026';

  static final List<GroupMember> members = [
    GroupMember(nama: 'Khatama Putra', nim: '123230053'),
    GroupMember(nama: 'Bintoro', nim: '123230059'),
    GroupMember(nama: 'Naurah Rifdah Nur Ramadhani', nim: '123230068'),
    GroupMember(nama: 'Muhammad Luqmaan', nim: '123230070'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.navy,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 18, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(color: AppColors.divider),
                child: Stack(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColors.sand.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                        color: AppColors.sand.withOpacity(0.4),
                                        width: 1.5),
                                  ),
                                  child: const Icon(Icons.group_outlined,
                                      color: AppColors.navy, size: 28),
                                ),
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      namaKelompok,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      mataKuliah,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            Row(
                              children: [
                                _Chip(label: semester),
                                const SizedBox(width: 8),
                                _Chip(label: tahunAjaran),
                                const SizedBox(width: 8),
                                _Chip(label: '${members.length} Anggota'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: SectionHeader(
                          title: 'Daftar Anggota', icon: Icons.people_outline),
                    );
                  }
                  final member = members[index - 1];
                  return _MemberTile(number: index, member: member);
                },
                childCount: members.length + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: AppColors.textPrimary.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: AppColors.textPrimary, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final int number;
  final GroupMember member;

  const _MemberTile({required this.number, required this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.badge_outlined,
                          size: 13, color: AppColors.textSub),
                      const SizedBox(width: 4),
                      Text(
                        'NIM: ${member.nim}',
                        style: const TextStyle(
                            fontSize: 12.5, color: AppColors.textSub),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  member.nama.isNotEmpty
                      ? member.nama[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
