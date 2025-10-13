import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'Meus Projetos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'LivestiTIW.builder',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 16),
          _ProjectCard(
            title: 'App de Notas',
            description: 'Aplicativo móvel para gerenciar tarefas diárias.',
            status: 'Em Well', // "Em andamento"
            statusColor: Colors.orange,
          ),
          SizedBox(height: 12),
          _ProjectCard(
            title: 'API de Chatbot',
            description: 'Aplicativo móvel para gerenciar tarefas diárias.',
            status: 'Sendluto', // "Enviado"
            statusColor: Colors.blue,
          ),
          SizedBox(height: 12),
          _ProjectCard(
            title: 'API de Chatbot',
            description: 'Aplicativo móvel para mensagens dentro de renstam.',
            status: 'Concluído',
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para os cards de projeto
class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final Color statusColor;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.folder_open, color: Colors.orange),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}