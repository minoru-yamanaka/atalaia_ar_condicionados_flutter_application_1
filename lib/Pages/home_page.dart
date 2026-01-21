import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Importe o pacote
import 'package:atalaia_ar_condicionados_flutter_application/Widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de imagens para o carrossel (Substitua pelos seus caminhos)
  final List<String> bannerImages = [
    'assets/img/Atalaiabanner.png',
    'assets/img/higienizacao.png',
    'assets/img/manutencao.png', // Adicione outras imagens aqui
    'assets/img/economizar.png',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua Empresa de Climatização'),
        backgroundColor: const Color(0xFF0C1D34),
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: [
          // --- INÍCIO DO CARROSSEL ---
          const SizedBox(height: 16),
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true, // Gira sozinho
                  enlargeCenterPage: true, // Destaca a imagem central
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // Indicadores (Pontinhos)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bannerImages.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color(0xFF0C1D34))
                              .withOpacity(
                                _currentIndex == entry.key ? 0.9 : 0.4,
                              ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // --- FIM DO CARROSSEL ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Conforto e Eficiência Para Seu Ambiente',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Oferecemos as melhores soluções em climatização residencial e comercial. Instalação, manutenção e projetos personalizados.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Divider(),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Text(
              'Nossos Serviços Disponíveis',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // Lista de Serviços
          ProductCard(
            imagePath: 'assets/img/higienizacao.png',
            title: 'Higienização Completa',
            description:
                'Elimine ácaros, fungos e bactérias, garantindo um ar mais puro.',
            price: 'Consulte',
          ),
          ProductCard(
            imagePath: 'assets/img/manutencao.png',
            title: 'Manutenção Preventiva',
            description:
                'Aumente a vida útil do seu equipamento e evite quebras.',
            price: 'Consulte',
          ),
          ProductCard(
            imagePath: 'assets/img/economizar.png',
            title: 'Instalação Profissional',
            description:
                'Instalamos seu ar condicionado seguindo todas as normas técnicas.',
            price: 'Consulte',
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
