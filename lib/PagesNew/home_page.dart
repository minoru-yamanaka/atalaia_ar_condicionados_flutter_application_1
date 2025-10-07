import 'package:flutter/material.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua Empresa de Climatização'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: [
          // Seção Destaques
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Conforto e Eficiência Para Seu Ambiente',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Oferecemos as melhores soluções em climatização residencial e comercial. Instalação, manutenção e projetos personalizados com a garantia de quem entende do assunto.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/img/imagem-destaque.jpg'), // Substitua pelo caminho da sua imagem
                ),
              ],
            ),
          ),

          // Divisor e Título da Seção Produtos
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Nossos Produtos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // Seção Produtos
          ProductCard(
            imagePath: 'assets/img/produtos/imagem_01.png',
            title: 'Ar Condicionado Split Inverter',
            description: 'Tecnologia inverter para maior economia de energia e conforto térmico constante.',
            price: 'R\$ 1.999,90',
          ),
          ProductCard(
            imagePath: 'assets/img/produtos/imagem_02.png',
            title: 'Ar Condicionado Piso Teto',
            description: 'Potência e versatilidade para grandes ambientes comerciais.',
            price: 'R\$ 3.499,90',
          ),
          ProductCard(
            imagePath: 'assets/img/produtos/imagem_03.png',
            title: 'Cortina de Ar',
            description: 'Ideal para entradas de lojas e ambientes com alto fluxo de pessoas.',
            price: 'R\$ 899,90',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}