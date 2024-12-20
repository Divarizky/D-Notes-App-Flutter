import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Heading Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Notes',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.favorite, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Search Bar Section
              TextField(
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: 'Search notes',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button Section
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.add, color: Colors.white, size: 38),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
