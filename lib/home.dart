import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'onboarding.dart';
import 'user.dart'; // <<< ADDED: Import the ProfilePage

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Barbershop Home',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Color darkGreen = const Color(0xFF385E38);
  final Color lightPinkBackground = const Color(0xFFF7E4E4);
  final Color iconBackground = const Color(0xFF2E4D2E);
  final Color whiteBackground = Colors.white;

  int _selectedIndex = 0;

  final List<Map<String, dynamic>> serviceCategories = const [
    {
      'categoryTitle': 'HAIR SERVICES',
      'items': [
        {
          'title': 'HAIR CUT',
          'icon': Icons.content_cut,
          'description':
          'Achieve your desired look with a professional fade, trim, or style.'
        },
        {
          'title': 'HAIR COLORING & STYLING',
          'icon': Icons.palette,
          'description':
          'Expert coloring techniques, highlights, and custom styling for a vibrant finish.'
        },
        {
          'title': 'HAIR TREATMENT',
          'icon': Icons.local_florist,
          'description':
          'Nourishing treatments to strengthen and repair hair damage and promote shine.'
        },
      ]
    },
    {
      'categoryTitle': 'SKIN SERVICES',
      'items': [
        {
          'title': 'FACIAL',
          'icon': Icons.spa,
          'description':
          'Deep cleansing and hydration to rejuvenate, exfoliate, and refresh your skin.'
        },
        {
          'title': 'WAXING',
          'icon': Icons.clean_hands,
          'description':
          'Smooth and long-lasting hair removal for a clean and silky skin finish.'
        },
        {
          'title': 'LASER HAIR REMOVAL',
          'icon': Icons.flash_on,
          'description':
          'Permanent reduction of unwanted hair using advanced, safe laser technology.'
        },
        {
          'title': 'SKIN WHITENING & BRIGHTENING',
          'icon': Icons.brightness_7,
          'description':
          'Specialized treatments to enhance skin tone and reduce pigmentation.'
        },
      ]
    },
    {
      'categoryTitle': 'NAIL SERVICES',
      'items': [
        {
          'title': 'NAIL ART',
          'icon': Icons.color_lens,
          'description':
          'Custom designs and intricate artwork to make your manicure unique.'
        },
        {
          'title': 'NAIL EXTENSIONS',
          'icon': Icons.brush,
          'description':
          'Durable and natural-looking extensions using gel or acrylic for added length.'
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPinkBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "GOOD MORNING",
                    style: TextStyle(
                      color: darkGreen.withOpacity(0.7),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "SRUSHTI",
                    style: TextStyle(
                      color: darkGreen,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 120.0),
                    child: Divider(
                      color: darkGreen.withOpacity(0.5),
                      thickness: 1.0,
                      height: 20.0,
                    ),
                  ),
                  Text(
                    "Explore our salon services and let your \nbeauty bloom 💅✨",
                    style: TextStyle(
                      color: darkGreen.withOpacity(0.7),
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),

            // List of Categories
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: whiteBackground),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: serviceCategories.map((category) {
                    return _buildServiceCategory(
                      categoryTitle: category['categoryTitle'],
                      items: category['items'],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: darkGreen,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 0) {
            // Home button currently navigates to Onboarding (as per your original code)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Onboarding()),
            );
          } else if (index == 1) {
            // <<< CRITICAL FIX: Navigate to the User Profile Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
      ),
    );
  }

  /// Build Service Category
  Widget _buildServiceCategory({
    required String categoryTitle,
    required List<Map<String, dynamic>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
          child: Text(
            categoryTitle,
            style: TextStyle(
              color: darkGreen,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),

        ...items.map((item) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    title: item['title'],
                    description: item['description'],
                    icon: item['icon'],
                  ),
                ),
              );
            },
            child: _buildServiceItem(
              icon: item['icon'],
              title: item['title'],
              description: item['description'],
            ),
          );
        }).toList(),
      ],
    );
  }

  /// Build single service item
  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 20),

              // Title & Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Divider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            color: Colors.black26.withOpacity(0.3),
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
