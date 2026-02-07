import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../providers/university_provider.dart';
import '../../widgets/university_card.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
    void initState() {
        super.initState();
        // Fetch universities when screen loads
        WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<UniversityProvider>(context, listen: false).fetchUniversities();
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // Header
                            const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text('Find your dream', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                            Text('University', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                        ],
                                    ),
                                    CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person, color: Colors.white)),
                                ],
                            ),
                            const SizedBox(height: 24),

                            // Search Bar
                            TextField(
                                style: const TextStyle(color: Colors.white),
                                onSubmitted: (value) {
                                     Provider.of<UniversityProvider>(context, listen: false).fetchUniversities(keyword: value);
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.cardBackground,
                                    hintText: 'Search for universities...',
                                    hintStyle: const TextStyle(color: Colors.white38),
                                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                ),
                            ),
                            const SizedBox(height: 24),

                            // Categories (Mocked)
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                    _buildCategoryItem(Icons.compare_arrows, 'Compare'),
                                    _buildCategoryItem(Icons.emoji_events, 'Scholarship'),
                                    _buildCategoryItem(Icons.book, 'Programs'),
                                    _buildCategoryItem(Icons.event, 'Events'),
                                ],
                            ),
                            const SizedBox(height: 24),

                            // Top Universities Header
                            const Text('Top Universities', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),

                            // List
                            Expanded(
                                child: Consumer<UniversityProvider>(
                                    builder: (context, provider, child) {
                                        if (provider.isLoading) {
                                            return const Center(child: CircularProgressIndicator());
                                        }
                                        if (provider.universities.isEmpty) {
                                            return const Center(child: Text('No universities found', style: TextStyle(color: Colors.white)));
                                        }
                                        return ListView.builder(
                                            itemCount: provider.universities.length,
                                            itemBuilder: (context, index) {
                                                return UniversityCard(university: provider.universities[index]);
                                            },
                                        );
                                    },
                                ),
                            ),
                        ],
                    ),
                ),
            ),
             bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppColors.cardBackground,
                selectedItemColor: AppColors.highlight,
                unselectedItemColor: Colors.white38,
                items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saved'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                ],
            ),
        );
    }

    Widget _buildCategoryItem(IconData icon, String label) {
        return Column(
            children: [
                Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(12)),
                    child: Icon(icon, color: AppColors.highlight),
                ),
                const SizedBox(height: 8),
                Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
        );
    }
}
