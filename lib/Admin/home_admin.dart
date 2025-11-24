import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  // ---------- TOTAL USERS ----------
  Stream<int> getTotalUsers() {
    return FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // ---------- STATIC SERVICE COUNTS ----------
  final int hairCount = 3;
  final int skinCount = 4;
  final int nailCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Femlora Salon - Dashboard"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Total Services Offered",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // ------------ SERVICE CARDS -------------
            Row(
              children: [
                // HAIR SERVICE
                Expanded(
                  child: Card(
                    color: Colors.orange.shade50,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const Icon(Icons.cut, size: 40, color: Colors.orange),
                          const SizedBox(height: 10),
                          const Text("Hair Services",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("$hairCount",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // SKIN SERVICE
                Expanded(
                  child: Card(
                    color: Colors.pink.shade50,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const Icon(Icons.face_retouching_natural,
                              size: 40, color: Colors.pink),
                          const SizedBox(height: 10),
                          const Text("Skin Services",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("$skinCount",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // NAIL SERVICE
                Expanded(
                  child: Card(
                    color: Colors.purple.shade50,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const Icon(Icons.brush,
                              size: 40, color: Colors.purple),
                          const SizedBox(height: 10),
                          const Text("Nail Services",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("$nailCount",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Total Registered Users",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // -------- USER COUNT CARD --------
            StreamBuilder<int>(
              stream: getTotalUsers(),
              builder: (context, snapshot) {
                int count = snapshot.data ?? 0;

                return Card(
                  elevation: 4,
                  color: Colors.blue.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      children: [
                        const Icon(Icons.people,
                            size: 45, color: Colors.blue),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Registered Users",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "$count",
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
