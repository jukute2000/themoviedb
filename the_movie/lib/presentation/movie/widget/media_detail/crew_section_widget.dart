import 'package:flutter/material.dart';

class CrewSection extends StatelessWidget {
  const CrewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InfoPerson(name: "Marc Webb", role: "Director"),
          _InfoPerson(name: "Erin Cressida Wilson", role: "Screenplay"),
        ],
      ),
    );
  }
}

class _InfoPerson extends StatelessWidget {
  final String name;
  final String role;

  const _InfoPerson({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        Text(role, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
