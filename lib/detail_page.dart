import 'package:femlorasalon/Admin/admin_login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home.dart';
import 'onboarding.dart';
// 1. ADD NEW IMPORT FOR ADMIN LOGIN PAGE
import 'package:femlorasalon/Admin/admin_login.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;

  const DetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime selectedDate = DateTime.now();
  int selectedTimeIndex = -1;

  final List<String> timeSlots = [
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "3:00 PM",
    "4:00 PM",
    "5:00 PM",
    "6:00 PM",
  ];

  int _selectedIndex = 0;

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  String billingCountry = 'India';
  bool saveInfo = false;

  int getPriceForService(String title) {
    final t = title.toLowerCase();
    final hairKeywords = ['hair', 'cut', 'color', 'treatment', 'styling'];
    final nailKeywords = ['nail', 'manicure', 'nail art', 'extensions'];
    final skinKeywords = ['facial', 'wax', 'laser', 'skin', 'brightening'];

    if (hairKeywords.any((k) => t.contains(k))) return 1200;
    if (nailKeywords.any((k) => t.contains(k))) return 700;
    if (skinKeywords.any((k) => t.contains(k))) return 1500;
    return 999;
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Onboarding()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Home()));
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User profile coming soon 👤")),
      );
    }
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  void _openDemoPaymentSheet(BuildContext context, int amount) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.78,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFF232323),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ListView(
                controller: controller,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // MAKE PAYMENT BUTTON
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Link payment")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C853),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "Let's Make Payment and Confirm Slot",
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white12)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Or pay using", style: TextStyle(color: Colors.white70)),
                      ),
                      Expanded(child: Divider(color: Colors.white12)),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // CARD INPUT BOX
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Card number",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: expiryController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "MM / YY",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                ),

                                // Auto MM/YY formatting
                                onChanged: (value) {
                                  if (value.length == 2 && !value.contains("/")) {
                                    expiryController.text = "$value/";
                                    expiryController.selection = TextSelection.fromPosition(
                                      TextPosition(offset: expiryController.text.length),
                                    );
                                  }

                                  if (value.length == 2 && !expiryController.text.endsWith("/")) {
                                    expiryController.text = "$value/";
                                    expiryController.selection = TextSelection.fromPosition(
                                      TextPosition(offset: expiryController.text.length),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: TextField(
                                controller: cvcController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "CVC",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: billingCountry,
                      dropdownColor: const Color(0xFF3A3A3A),
                      decoration: const InputDecoration(border: InputBorder.none),
                      items: const [
                        DropdownMenuItem(value: 'India', child: Text('India')),
                        DropdownMenuItem(value: 'United States', child: Text('United States')),
                        DropdownMenuItem(value: 'United Kingdom', child: Text('United Kingdom')),
                      ],
                      onChanged: (v) => setState(() => billingCountry = v ?? 'India'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Checkbox(
                        value: saveInfo,
                        onChanged: (v) => setState(() => saveInfo = v ?? false),
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                      ),
                      const Expanded(
                        child: Text(
                          "Save your info for secure 1-click checkout.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.lock, color: Colors.white),
                    label: Text("Pay ₹$amount".toUpperCase()),
                  ),

                  const SizedBox(height: 8),

                  // PROCESSING BUTTON → SUCCESS PAGE
                  ElevatedButton(
                    onPressed: () {
                      if (cardNumberController.text.trim().length < 12 ||
                          expiryController.text.isEmpty ||
                          cvcController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please Enter Valid Card Details.")),
                        );
                        return;
                      }

                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentSuccessPage(price: amount),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C853),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Processing", style: TextStyle(color: Colors.black)),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int price = getPriceForService(widget.title);

    return Scaffold(
      backgroundColor: const Color(0xFFF6DC4E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER BLOCK
              Stack(
                children: [
                  Container(
                    height: 290,
                    decoration: const BoxDecoration(
                      color: Color(0xFFED19BF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),

                  // Back Button
                  Positioned(
                    top: 35,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),

                  // 2. ADMIN LOGIN BUTTON ADDED HERE
                  Positioned(
                    top: 10,
                    right: 16,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AdminLoginPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        "Admin Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 45,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(
                            "assets/images/srushti1.PNG",
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),

                        const Text(
                          "Srushti Shinde",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const Text(
                          "Professional Beautician & Hair Specialist",
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${widget.title} You Choosed",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          widget.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // SELECT DATE
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Your Date",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE6FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              selectedDate = DateTime(
                                  selectedDate.year, selectedDate.month - 1, 1);
                            });
                          },
                        ),
                        Text(
                          DateFormat.yMMMM().format(selectedDate),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            setState(() {
                              selectedDate = DateTime(
                                  selectedDate.year, selectedDate.month + 1, 1);
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ["S", "M", "T", "W", "T", "F", "S"]
                          .map((e) => Text(e))
                          .toList(),
                    ),

                    const SizedBox(height: 8),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      itemCount: 30,
                      itemBuilder: (_, i) {
                        final d = DateTime(selectedDate.year, selectedDate.month, i + 1);
                        final isSelected = d.day == selectedDate.day;

                        return GestureDetector(
                          onTap: () => setState(() => selectedDate = d),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF385E38) : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "${i + 1}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              const Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Your Time for Appointment",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: timeSlots.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.6,
                  ),
                  itemBuilder: (_, i) {
                    final isSelected = selectedTimeIndex == i;

                    return GestureDetector(
                      onTap: () => setState(() => selectedTimeIndex = i),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF385E38) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          timeSlots[i],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),

              ElevatedButton(
                onPressed: () {
                  if (selectedTimeIndex < 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a time slot first."),
                      ),
                    );
                    return;
                  }

                  _openDemoPaymentSheet(context, price);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDE4BF4),
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                ),
                child: const Text(
                  "Book Appointment ✨",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF40DC2),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_service_outlined),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "User",
          ),
        ],
      ),
    );
  }
}

// SUCCESS PAGE

class PaymentSuccessPage extends StatelessWidget {
  final int price;

  const PaymentSuccessPage({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Home()),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_rounded, size: 120, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Payment Successful 🎉",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "You have been charged ₹$price",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 6),
            const Text(
              "Your slot has been booked!",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}