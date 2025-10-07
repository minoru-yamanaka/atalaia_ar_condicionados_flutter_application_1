import 'package:flutter/material.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Widgets/service_card.dart';

class ServicosPage extends StatelessWidget {
  const ServicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nossos Serviços'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ServiceCard(
            imagePath: 'assets/img/servicos/imagem_01.png',
            title: 'Instalação Profissional',
            description: 'Instalamos equipamentos de ar condicionado de todas as marcas e modelos, seguindo as normas técnicas para garantir a máxima eficiência e segurança.',
          ),
          SizedBox(height: 16),
          ServiceCard(
            imagePath: 'assets/img/servicos/imagem_02.jpg',
            title: 'Manutenção Preventiva',
            description: 'Aumente a vida útil do seu equipamento e garanta um ar mais puro com nosso plano de manutenção preventiva e higienização completa.',
          ),
          SizedBox(height: 16),
          ServiceCard(
            imagePath: 'assets/img/servicos/imagem_03.jpg',
            title: 'Projetos de Climatização',
            description: 'Desenvolvemos projetos personalizados para residências, escritórios e grandes espaços comerciais, otimizando o conforto térmico e o consumo de energia.',
          ),
        ],
      ),
    );
  }
}