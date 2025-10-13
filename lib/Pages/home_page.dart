import 'package:flutter/material.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/Widgets/product_card.dart';

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
          // Seção Destaques (Banner e texto inicial)
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
                  // Mantenha sua imagem de destaque ou substitua
                  child: Image.asset('assets/img/imagem-destaque.jpg'), 
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0), // Ajustado padding
            child: Text(
              'Nossos Serviços Disponíveis',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // --- INÍCIO DA LISTA DE SERVIÇOS ATUALIZADA ---

          ProductCard(
            // ATENÇÃO: Verifique se o caminho da imagem está correto
            imagePath: 'assets/img/servicos/imagem_higienizacao.png', 
            title: 'Higienização Completa',
            description: 'Elimine ácaros, fungos e bactérias, garantindo um ar mais puro e a saúde da sua família.',
            price: 'Consulte', // Preço flexível para serviços
          ),
          ProductCard(
            imagePath: 'assets/img/servicos/imagem_manutencao.jpg',
            title: 'Manutenção Preventiva',
            description: 'Aumente a vida útil do seu equipamento e evite quebras inesperadas com nossa revisão completa.',
            price: 'Consulte',
          ),
          ProductCard(
            imagePath: 'assets/img/servicos/imagem_instalacao.png',
            title: 'Instalação Profissional',
            description: 'Instalamos seu ar condicionado seguindo todas as normas técnicas para máxima eficiência e segurança.',
            price: 'Consulte',
          ),
          ProductCard(
            imagePath: 'assets/img/servicos/imagem_infra.jpg',
            title: 'Projeto e Infraestrutura',
            description: 'Preparamos toda a estrutura de tubulação e elétrica para a instalação do seu ar condicionado, mesmo antes da obra.',
            price: 'Consulte',
          ),
          ProductCard(
            imagePath: 'assets/img/servicos/imagem_outros.jpg',
            title: 'Outros Serviços (Sob Demanda)',
            description: 'Tem uma necessidade específica? Entre em contato e encontraremos a solução ideal para seu projeto de climatização.',
            price: 'Consulte',
          ),
          const SizedBox(height: 20), // Um espaço no final da lista

          // --- FIM DA LISTA DE SERVIÇOS ---
        ],
      ),
    );
  }
}