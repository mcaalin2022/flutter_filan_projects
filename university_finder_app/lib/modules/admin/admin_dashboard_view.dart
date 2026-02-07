import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/utils/colors.dart';
import 'package:university_finder_app/modules/admin/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Admin Console'),
        backgroundColor: AppColors.surface,
        actions: [
          IconButton(
            onPressed: () => controller.fetchAllData(),
            icon: const Icon(Icons.refresh, color: AppColors.primary),
            tooltip: 'Refresh Data',
          ),
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Logout',
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Stats'),
            Tab(icon: Icon(Icons.people), text: 'Users'),
            Tab(icon: Icon(Icons.school), text: 'Unis'),
            Tab(icon: Icon(Icons.list_alt), text: 'Progs'),
            Tab(icon: Icon(Icons.assignment), text: 'Apps'),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return TabBarView(
          controller: controller.tabController,
          children: [
            _buildStatsTab(),
            _buildUsersTab(),
            _buildUniversitiesTab(),
            _buildProgramsTab(),
            _buildApplicationsTab(),
          ],
        );
      }),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildFab() {
    return Obx(() {
      final index = controller.selectedIndex.value;

      // Tab mapping: 0:Stats, 1:Users, 2:Unis, 3:Progs
      if (index == 1) { // Users Tab
        return FloatingActionButton(
          heroTag: 'add_user_tab',
          onPressed: () => _showCreateUserDialog(),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.person_add, color: Colors.white),
        );
      } else if (index == 2) { // Unis Tab
        return FloatingActionButton(
          heroTag: 'add_uni_tab',
          onPressed: () => _showUniversityDialog(),
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.business, color: Colors.white),
        );
      } else if (index == 3) { // Progs Tab
        return FloatingActionButton(
          heroTag: 'add_prog_tab',
          onPressed: () => _showProgramDialog(),
          backgroundColor: Colors.orangeAccent,
          child: const Icon(Icons.list_alt, color: Colors.white),
        );
      }

      // Hide FAB on Stats Tab (Index 0)
      return const SizedBox();
    });
  }

  void _showCreateUserDialog() {
    final nameCol = TextEditingController();
    final emailCol = TextEditingController();
    final passCol = TextEditingController();
    final confirmPassCol = TextEditingController();
    String role = 'user';

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Create New User', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCol, decoration: const InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: emailCol, decoration: const InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.grey))),
            TextField(controller: passCol, decoration: const InputDecoration(labelText: 'Password', labelStyle: TextStyle(color: Colors.grey)), obscureText: true),
            TextField(controller: confirmPassCol, decoration: const InputDecoration(labelText: 'Confirm Password', labelStyle: TextStyle(color: Colors.grey)), obscureText: true),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: role,
              dropdownColor: AppColors.surface,
              style: const TextStyle(color: Colors.white),
              items: ['user', 'admin'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (val) => role = val!,
              decoration: const InputDecoration(labelText: 'Role', labelStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          Obx(() => controller.isCreatingUser.value 
            ? const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () async {
                  if (passCol.text != confirmPassCol.text) {
                    Get.snackbar('Error', 'Passwords do not match');
                    return;
                  }
                  await controller.createUser(nameCol.text, emailCol.text, passCol.text, role);
                },
                child: const Text('Create'),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    final s = controller.stats;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildStatCard('Total Universities', s['totalUniversities']?.toString() ?? '0', Icons.business, Colors.blue),
          const SizedBox(height: 16),
          _buildStatCard('Total Registrations', s['totalApplications']?.toString() ?? '0', Icons.assignment, Colors.green),
          const SizedBox(height: 16),
          _buildStatCard('Total Students', s['totalStudents']?.toString() ?? '0', Icons.people_outline, Colors.orange),
          const SizedBox(height: 16),
          _buildStatCard('Total Admins', s['totalAdmins']?.toString() ?? '0', Icons.admin_panel_settings, Colors.purple),
          const SizedBox(height: 16),
          _buildStatCard('Total System Users', s['totalUsers']?.toString() ?? '0', Icons.groups, Colors.grey),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsersTab() {
    return Column(
      children: [
        // Table Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.white.withOpacity(0.05),
          child: Row(
            children: const [
              Expanded(flex: 3, child: Text('USER INFO', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12))),
              Expanded(flex: 2, child: Text('ROLE', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12))),
              SizedBox(width: 48), // Action space
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: controller.users.length,
            separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 1),
            itemBuilder: (context, index) {
              final user = controller.users[index];
              final isAdmin = user['role'] == 'admin';
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isAdmin ? AppColors.primary : Colors.grey.withOpacity(0.2),
                    child: Text(user['name'][0].toUpperCase(), style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(user['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(user['email'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (isAdmin ? Colors.purple : Colors.blue).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: (isAdmin ? Colors.purple : Colors.blue).withOpacity(0.5)),
                        ),
                        child: Text(
                          isAdmin ? 'ADMIN' : 'STUDENT',
                          style: TextStyle(color: isAdmin ? Colors.purpleAccent : Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert, color: Colors.grey),
                        onSelected: (val) {
                          if (val == 'delete') {
                            Get.dialog(
                              AlertDialog(
                                backgroundColor: AppColors.surface,
                                title: const Text('Delete User', style: TextStyle(color: Colors.white)),
                                content: const Text('Are you sure you want to delete this user?', style: TextStyle(color: Colors.grey)),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    onPressed: () {
                                      controller.deleteUser(user['_id']);
                                      Get.back();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (val == 'promote') controller.updateUserRole(user['_id'], 'admin');
                          if (val == 'demote') controller.updateUserRole(user['_id'], 'user');
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: isAdmin ? 'demote' : 'promote', 
                            child: Row(
                              children: [
                                Icon(isAdmin ? Icons.person : Icons.admin_panel_settings, size: 18),
                                const SizedBox(width: 8),
                                Text(isAdmin ? 'Revoke Admin' : 'Grant Admin'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete', 
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red, size: 18),
                                SizedBox(width: 8),
                                Text('Delete', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationsTab() {
    return ListView.builder(
      itemCount: controller.applications.length,
      itemBuilder: (context, index) {
        final app = controller.applications[index];
        return Card(
          color: AppColors.surface,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ExpansionTile(
            title: Text(app['fullName'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text('Applied to: ${app['universityId']['name']}', style: const TextStyle(color: AppColors.primary)),
            leading: const Icon(Icons.description, color: Colors.grey),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Phone', app['phone'] ?? 'N/A'),
                    _infoRow('Address', app['address'] ?? 'N/A'),
                    _infoRow('School', app['graduateSchool'] ?? 'N/A'),
                    _infoRow('Grade', app['grade'] ?? 'N/A'),
                    _infoRow('Gender', app['gender'] ?? 'N/A'),
                    _infoRow('Faculties', (app['facultiesInterested'] as List).join(', ')),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                backgroundColor: AppColors.surface,
                                title: const Text('Delete Application', style: TextStyle(color: Colors.white)),
                                content: const Text('Are you sure you want to delete this application?', style: TextStyle(color: Colors.grey)),
                                actions: [
                                  TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    onPressed: () {
                                      controller.deleteApplication(app['_id']);
                                      Get.back();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUniversitiesTab() {
    return ListView.builder(
      itemCount: controller.universities.length,
      itemBuilder: (context, index) {
        final uni = controller.universities[index];
        return ListTile(
          leading: uni['imageUrl'] != null 
            ? CircleAvatar(backgroundImage: NetworkImage(uni['imageUrl'])) 
            : const CircleAvatar(child: Icon(Icons.school)),
          title: Text(uni['name'] ?? 'University', style: const TextStyle(color: Colors.white)),
          subtitle: Text(uni['location'] ?? 'Somalia', style: const TextStyle(color: Colors.grey)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                onPressed: () => _showUniversityDialog(uni: uni),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: AppColors.surface,
                      title: const Text('Delete University', style: TextStyle(color: Colors.white)),
                      content: const Text('Are you sure you want to delete this university?', style: TextStyle(color: Colors.grey)),
                      actions: [
                        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            controller.deleteUniversity(uni['_id']);
                            Get.back();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgramsTab() {
    return ListView.builder(
      itemCount: controller.programs.length,
      itemBuilder: (context, index) {
        final prog = controller.programs[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.list_alt)),
          title: Text(prog['name'] ?? 'Program', style: const TextStyle(color: Colors.white)),
          subtitle: Text('${prog['universityId']?['name'] ?? 'Unknown'} • ${prog['duration']}', 
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                onPressed: () => _showProgramDialog(prog: prog),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: AppColors.surface,
                      title: const Text('Delete Program', style: TextStyle(color: Colors.white)),
                      content: const Text('Are you sure you want to delete this program?', style: TextStyle(color: Colors.grey)),
                      actions: [
                        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            controller.deleteProgram(prog['_id']);
                            Get.back();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUniversityDialog({Map? uni}) {
    final nameCol = TextEditingController(text: uni?['name']);
    final locCol = TextEditingController(text: uni?['location']);
    final tuitionCol = TextEditingController(text: uni?['tuitionRange']);
    final contactCol = TextEditingController(text: uni?['contactInfo']);

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(uni == null ? 'Add University' : 'Update University', style: const TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCol, decoration: const InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: locCol, decoration: const InputDecoration(labelText: 'Location', labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: tuitionCol, decoration: const InputDecoration(labelText: 'Tuition Range', labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: contactCol, decoration: const InputDecoration(labelText: 'Contact Info', labelStyle: TextStyle(color: Colors.grey))),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          Obx(() => controller.isCreatingUniversity.value 
            ? const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () async {
                  final data = {
                    'name': nameCol.text,
                    'location': locCol.text,
                    'tuitionRange': tuitionCol.text,
                    'contactInfo': contactCol.text,
                  };
                  if (uni == null) {
                    await controller.createUniversity(data);
                  } else {
                    await controller.updateUniversity(uni['_id'], data);
                  }
                },
                child: Text(uni == null ? 'Create' : 'Update'),
              )
          ),
        ],
      ),
    );
  }

  void _showProgramDialog({Map? prog}) {
    final nameCol = TextEditingController(text: prog?['name']);
    final durCol = TextEditingController(text: prog?['duration']);
    final reqCol = TextEditingController(text: prog?['requirements']);
    String? selectedUniId = prog?['universityId']?['_id'] ?? (controller.universities.isNotEmpty ? controller.universities[0]['_id'] : null);

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(prog == null ? 'Add Program' : 'Update Program', style: const TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: selectedUniId,
                dropdownColor: AppColors.surface,
                style: const TextStyle(color: Colors.white),
                items: controller.universities.map<DropdownMenuItem<String>>((u) => 
                  DropdownMenuItem(value: u['_id'], child: Text(u['name'], style: const TextStyle(fontSize: 12)))).toList(),
                onChanged: (val) => selectedUniId = val,
                decoration: const InputDecoration(labelText: 'University', labelStyle: TextStyle(color: Colors.grey)),
              ),
              TextField(controller: nameCol, decoration: const InputDecoration(labelText: 'Program Name', labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: durCol, decoration: const InputDecoration(labelText: 'Duration', labelStyle: TextStyle(color: Colors.grey))),
              TextField(controller: reqCol, decoration: const InputDecoration(labelText: 'Requirements', labelStyle: TextStyle(color: Colors.grey))),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          Obx(() => controller.isCreatingProgram.value
            ? const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () async {
                  if (selectedUniId == null) {
                    Get.snackbar('Error', 'Please select a university');
                    return;
                  }
                  final data = {
                    'universityId': selectedUniId,
                    'name': nameCol.text,
                    'duration': durCol.text,
                    'requirements': reqCol.text,
                  };
                  if (prog == null) {
                    await controller.createProgram(data);
                  } else {
                    await controller.updateProgram(prog['_id'], data);
                  }
                },
                child: Text(prog == null ? 'Create' : 'Update'),
              )
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
