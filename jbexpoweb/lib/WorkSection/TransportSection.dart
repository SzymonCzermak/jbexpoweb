import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jbexpoweb/responsive_appbar.dart';

class HowWeWorkPage extends StatefulWidget {
  final bool isPolish;

  const HowWeWorkPage({Key? key, required this.isPolish}) : super(key: key);

  @override
  State<HowWeWorkPage> createState() => _HowWeWorkPageState();
}

class _HowWeWorkPageState extends State<HowWeWorkPage>
    with SingleTickerProviderStateMixin {
  late bool isPolish;
  late AnimationController _controller;
  late List<Animation<double>> _opacityAnimations;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    isPolish = widget.isPolish; // Inicjalizacja języka
    _controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    );

    _opacityAnimations = List.generate(
      8,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index / 8,
            (index + 1) / 8,
            curve: Curves.easeOutQuart,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant HowWeWorkPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPolish != widget.isPolish) {
      setState(() {
        isPolish = widget.isPolish;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            _scrollController.jumpTo(
              _scrollController.offset + pointerSignal.scrollDelta.dy,
            );
          }
        },
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            _scrollController.jumpTo(
              _scrollController.offset - details.primaryDelta!,
            );
          },
          child: Stack(
            children: [
              // Tło
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Background3.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  // Główna zawartość
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        if (index < 7) {
                          return FadeTransition(
                            opacity: _opacityAnimations[index],
                            child: Column(
                              children: [
                                _buildResponsiveSection(
                                  number: index + 1,
                                  title: _getTitle(index + 1),
                                  description: _getDescription(index + 1),
                                  imagePath: _getImagePath(index + 1),
                                ),
                                if (index < 6) _buildArrowBetweenSections(),
                              ],
                            ),
                          );
                        } else {
                          return FadeTransition(
                            opacity: _opacityAnimations[index],
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 194, 181, 0),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 30.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  isPolish
                                      ? "Powrót do strony głównej"
                                      : "Go to Next Page",
                                  style: GoogleFonts.michroma(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: const Offset(2, 2),
                                        blurRadius: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArrowBetweenSections() {
    return Icon(
      Icons.arrow_downward,
      size: 50,
      color: const Color.fromARGB(255, 194, 181, 0),
    );
  }

  String _getTitle(int number) {
    switch (number) {
      case 1:
        return isPolish ? "Rozmowa to podstawa" : "Conversation is the Key";
      case 2:
        return isPolish ? "Podział obowiązków" : "Task Allocation";
      case 3:
        return isPolish ? "Transport" : "Transport";
      case 4:
        return isPolish ? "Montaż" : "Assembly";
      case 5:
        return isPolish ? "Magazyn" : "Storage";
      case 6:
        return isPolish ? "Demontaż" : "Disassembly";
      case 7:
        return isPolish ? "Uśmiech klienta" : "Client's Smile";
      default:
        return "";
    }
  }

  String _getDescription(int number) {
    switch (number) {
      case 1:
        return isPolish
            ? "Każdy projekt zaczyna się od rozmowy. Uważnie słuchamy Twoich potrzeb i celów, aby stworzyć idealny projekt. Nasz zespół biurowy dba o to, aby informacje trafiały dokładnie do kierownika stolarki, co pozwala na realizację projektu zgodnie z założeniami."
            : "Every project starts with a conversation. We carefully listen to your needs and goals to create the perfect design. Our office team ensures that information is accurately conveyed to the workshop manager, enabling smooth project execution.";
      case 2:
        return isPolish
            ? "Kierownik stolarnii rozdziela zadania pomiędzy członków zespołu, zapewniając płynność działań. Pracownicy realizują swoje obowiązki z najwyższą precyzją, korzystając z nowoczesnego sprzętu, w tym maszyn CNC."
            : "The workshop manager assigns tasks among team members, ensuring smooth operations. Workers perform their duties with the utmost precision, using modern equipment, including CNC machines.";
      case 3:
        return isPolish
            ? "Organizacja transportu to jedna z naszych mocnych stron. Dbamy o to, aby załadunek tirów przebiegał szybko i dokładnie, a towary były odpowiednio zapakowane i zabezpieczone na czas transportu."
            : "Transport organization is one of our strong points. We ensure quick and precise truck loading, with goods properly packed and secured for transport.";
      case 4:
        return isPolish
            ? "Nasz zespół montażowy działa na miejscu wydarzenia targowego, z pełnym zaangażowaniem i pasją montując stoisko, które spełnia wszystkie oczekiwania klienta."
            : "Our assembly team works on-site at trade events, assembling booths with full commitment and passion to meet all client expectations.";
      case 5:
        return isPolish
            ? "Po zakończeniu montażu, elementy stoiska są magazynowane w odpowiednich warunkach. Dbamy o porządek i zgodność z normami ekologicznymi, co pozwala na ponowne ich wykorzystanie w przyszłości."
            : "After assembly, booth components are stored in appropriate conditions. We ensure cleanliness and compliance with ecological standards, enabling their reuse in the future.";
      case 6:
        return isPolish
            ? "Po zakończeniu wydarzenia nasz zespół przystępuje do demontażu. Wszystkie prace są prowadzone z najwyższą starannością, pozostawiając miejsce w nienagannym stanie."
            : "After the event, our team begins disassembly. All work is carried out with the utmost care, leaving the site in impeccable condition.";
      case 7:
        return isPolish
            ? "Najlepszym podsumowaniem naszej pracy jest uśmiech zadowolonego klienta oraz ciepłe słowa uznania. To dla nas najcenniejsza nagroda, która motywuje nas do dalszego działania."
            : "The best summary of our work is the smile of a satisfied client and warm words of appreciation. This is our most valuable reward, motivating us to keep moving forward.";
      default:
        return "";
    }
  }

  Widget _buildResponsiveSection({
    required int number,
    required String title,
    required String description,
    required String imagePath,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double horizontalMargin = constraints.maxWidth > 1200 ? 350.0 : 40.0;
        double titleFontSize = constraints.maxWidth > 800 ? 80.0 : 35.0;
        double descFontSize = constraints.maxWidth > 800 ? 18.0 : 10.0;

        double imageWidth = constraints.maxWidth * 0.45;
        double imageHeight = constraints.maxWidth * 0.25;

        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20.0, horizontal: horizontalMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.michroma(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 194, 181, 0),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(134, 194, 181, 0),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(255, 97, 90, 0).withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                description,
                style: GoogleFonts.michroma(
                  fontSize: descFontSize,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 1),
            ],
          ),
        );
      },
    );
  }

  String _getImagePath(int number) {
    switch (number) {
      case 1:
        return 'assets/Work/Rozmowa.png';
      case 2:
        return 'assets/Work/Podzial.png';
      case 3:
        return 'assets/Work/Transport.png';
      case 4:
        return 'assets/Work/Montaz.png';
      case 5:
        return 'assets/Work/Magazyn.png';
      case 6:
        return 'assets/Work/Demontaz.png';
      case 7:
        return 'assets/Work/Usmiech.png';
      default:
        return 'assets/default.png';
    }
  }
}
