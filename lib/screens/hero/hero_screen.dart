import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_dex_go/models/hero_models.dart';
import 'package:hero_dex_go/services/api_client.dart';
import 'package:hero_dex_go/theme/theme_extensions.dart';

class HeroDetailScreen extends StatefulWidget {
  final String? heroId;
  const HeroDetailScreen({super.key, required this.heroId});

  @override
  State<HeroDetailScreen> createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  late Future<HeroModel> _heroFuture;

  @override
  void initState() {
    super.initState();
    _heroFuture = _fetchHero(widget.heroId!);
  }

  Future<bool> _checkIfHeroInCollection() async {
    return ApiClient().isHeroInCollection(widget.heroId!);
  }

  Future<void> _addToCollection() async {
    await ApiClient().addHeroToCollection(widget.heroId!);
  }

  Future<HeroModel> _fetchHero(String id) async {
    return ApiClient().getHeroById(id);
  }

  @override
  Widget build(BuildContext context) {
    // Kontrollera om vi är på webb/bred skärm för responsivitet
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF191022), // Din mörka bakgrund
      body: FutureBuilder<HeroModel>(
        future: _heroFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    "Error loading hero",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${snapshot.error}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _heroFuture = _fetchHero(widget.heroId!);
                      });
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Hero not found"));
          }

          final hero = snapshot.data!;
          // Use image URL or a placeholder
          final imageUrl =
              hero.image?.url ?? 'https://via.placeholder.com/400x800';
          final stats = hero.powerstats;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800), // Webbsäkring
              child: CustomScrollView(
                slivers: [
                  // 1. HERO HEADER (Bild + Titel)
                  SliverAppBar(
                    expandedHeight: 450,
                    pinned: true, // Behåll appbaren synlig när man scrollar
                    backgroundColor: const Color(0xFF191022),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black54,
                      ), // Glass-effekt
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Bilden
                          Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[800],
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.white54,
                                ),
                              );
                            },
                          ),
                          // Gradienten (Gör texten läsbar)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFF191022).withOpacity(0.5),
                                  const Color(
                                    0xFF191022,
                                  ), // Samma som bakgrundsfärgen
                                ],
                                stops: const [0.6, 0.85, 1.0],
                              ),
                            ),
                          ),
                          // Texten (Namn + Tags)
                          Positioned(
                            bottom: 20,
                            left: 16,
                            right: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hero.name,
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    if (hero.biography?.alignment != null)
                                      _buildTag(
                                        hero.biography!.alignment.toUpperCase(),
                                        hero.biography!.alignment == 'good'
                                            ? Colors.green.withOpacity(0.2)
                                            : Colors.redAccent.withOpacity(0.2),
                                        hero.biography!.alignment == 'good'
                                            ? Colors.green
                                            : Colors.redAccent,
                                      ),
                                    const SizedBox(width: 8),
                                    if (hero.appearance?.race != null &&
                                        hero.appearance!.race !=
                                            "null") // API returns string "null" sometimes
                                      _buildTag(
                                        hero.appearance!.race,
                                        Colors.purpleAccent.withOpacity(0.2),
                                        Colors.purpleAccent,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 2. STATS GRID
                  if (stats != null)
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        delegate: SliverChildListDelegate([
                          _buildStatCard(
                            "Intelligence",
                            stats.intelligence,
                            _parseStat(stats.intelligence),
                            Icons.psychology,
                          ),
                          _buildStatCard(
                            "Strength",
                            stats.strength,
                            _parseStat(stats.strength),
                            Icons.fitness_center,
                          ),
                          _buildStatCard(
                            "Speed",
                            stats.speed,
                            _parseStat(stats.speed),
                            Icons.flash_on,
                          ),
                          _buildStatCard(
                            "Durability",
                            stats.durability,
                            _parseStat(stats.durability),
                            Icons.shield,
                          ),
                          _buildStatCard(
                            "Power",
                            stats.power,
                            _parseStat(stats.power),
                            Icons.bolt,
                          ),
                          _buildStatCard(
                            "Combat",
                            stats.combat,
                            _parseStat(stats.combat),
                            Icons.sports_mma,
                          ),
                        ]),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isWideScreen
                              ? 4
                              : 2, 
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.4, 
                        ),
                      ),
                    ),

                  // 3. ORIGIN STORY / BIO
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2036),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.auto_stories,
                                  color: Color(0xFF7F0DF2),
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Biography",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              "Full Name",
                              hero.biography?.fullName ?? '-',
                            ),
                            _buildInfoRow(
                              "Alter Egos",
                              hero.biography?.alterEgo.join(", ") ?? '-',
                            ),
                            _buildInfoRow(
                              "Place of Birth",
                              hero.biography?.placeOfBirth ?? '-',
                            ),
                            _buildInfoRow(
                              "First Appearance",
                              hero.biography?.firstAppearance ?? '-',
                            ),
                            _buildInfoRow(
                              "Publisher",
                              hero.biography?.publisher ?? '-',
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildBottomNavigationBar(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  double _parseStat(String stat) {
    if (stat == "null" || stat.isEmpty) return 0.0;
    return (double.tryParse(stat) ?? 0) / 100.0;
  }

  Widget _buildBottomNavigationBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            _addToCollection();
          },
          icon: const Icon(Icons.add_box_outlined),
          label: const Text("Add to Collection"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7F0DF2),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    double percent,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2036),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey, size: 18),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 4, left: 4),
                child: Text(
                  "/100",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: context.colors.backgroundColor,
            color: context.colors.primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
