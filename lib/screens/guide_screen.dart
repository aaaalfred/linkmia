import 'package:flutter/material.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({Key? key}) : super(key: key);

  @override
  _GuideScreenState createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  final PageController _pageController = PageController();
  bool _acceptedTerms = false;
  int _currentPage = 0;

  final List<String> _images = [
    'assets/guide_image_1.png',
    'assets/guide_image_2.png',
    'assets/guide_image_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carrusel de imágenes
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                _images[index],
                fit: BoxFit.cover,
              );
            },
          ),
          // Indicadores de página
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _images.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == entry.key ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ),
          // Términos y condiciones y botón de avanzar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Color(0xFF00BFA5), // Color verde azulado
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Switch(
                        value: _acceptedTerms,
                        onChanged: (bool value) {
                          setState(() {
                            _acceptedTerms = value;
                          });
                        },
                        activeColor: Colors.white,
                      ),
                      Expanded(
                        child: Text(
                          'Acepto los términos y condiciones',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Avanzar'),
                    onPressed: _acceptedTerms ? () {
                      // Navegar a la siguiente pantalla
                      Navigator.of(context).pushReplacementNamed('/take_photo');
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}