import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jbexpoweb/FooterWidget.dart';

class HowWeWorkPage extends StatefulWidget {
  final bool isPolish;

  const HowWeWorkPage({Key? key, required this.isPolish}) : super(key: key);

  @override
  State<HowWeWorkPage> createState() => _HowWeWorkPageState();
}

class _HowWeWorkPageState extends State<HowWeWorkPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _pageController;
  late Animation<double> _pageAnimation;
  late List<AnimationController> _sectionControllers;
  late List<Animation<double>> _sectionAnimations;

  @override
  void initState() {
    super.initState();

    _pageController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _pageAnimation = CurvedAnimation(
      parent: _pageController,
      curve: Curves.easeOutExpo,
    );

    _sectionControllers = List.generate(
        7,
        (index) => AnimationController(
              duration: Duration(milliseconds: 2500),
              vsync: this,
            ));

    _sectionAnimations = _sectionControllers
        .map((controller) => CurvedAnimation(
              parent: controller,
              curve: Curves.easeOutExpo,
            ))
        .toList();

    _pageController.forward().then((_) async {
      for (var controller in _sectionControllers) {
        await Future.delayed(const Duration(milliseconds: 1000));
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _sectionControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            _handleScroll(pointerSignal);
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Background3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ScaleTransition(
                scale: _pageAnimation,
                child: FadeTransition(
                  opacity: _pageAnimation,
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      _buildHeader(),
                      _buildSections(),
                      const SizedBox(height: 40),
                      const FooterWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.isPolish ? "Sposób naszej pracy" : "How We Work",
          style: GoogleFonts.michroma(
            fontSize: MediaQuery.of(context).size.width > 800 ? 80 : 36,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 194, 181, 0),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          widget.isPolish
              ? "Zobacz, jak realizujemy Twoje targowe marzenia"
              : "See how we make your trade show dreams come true",
          style: GoogleFonts.michroma(
            fontSize: MediaQuery.of(context).size.width > 800 ? 24 : 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(
            color: Colors.white,
            thickness: 2,
            indent: 50,
            endIndent: 50,
          ),
        ),
      ],
    );
  }

  Widget _buildSections() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: List.generate(7, (index) {
            return FadeTransition(
              opacity: _sectionAnimations[index],
              child: ScaleTransition(
                scale: _sectionAnimations[index],
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
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildArrowBetweenSections() {
    return const Icon(
      Icons.arrow_downward,
      size: 50,
      color: Color.fromARGB(255, 194, 181, 0),
    );
  }

  void _handleScroll(PointerScrollEvent pointerSignal) {
    final double delta = pointerSignal.scrollDelta.dy;
    bool isTouchpad = delta.abs() < 50;
    double offsetChange = delta * (isTouchpad ? 0.5 : 1.0);

    double newOffset = _scrollController.offset + offsetChange;
    newOffset = newOffset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.jumpTo(newOffset);
  }

  Widget _buildResponsiveSection({
    required int number,
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.michroma(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 194, 181, 0),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            width: 600,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(134, 194, 181, 0),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 97, 90, 0).withOpacity(0.5),
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
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getTitle(int number) {
    switch (number) {
      case 1:
        return widget.isPolish
            ? "Rozmowa to podstawa"
            : "Conversation is the Key";
      case 2:
        return widget.isPolish ? "Podział obowiązków" : "Task Allocation";
      case 3:
        return widget.isPolish ? "Transport" : "Transport";
      case 4:
        return widget.isPolish ? "Montaż" : "Assembly";
      case 5:
        return widget.isPolish ? "Magazyn" : "Storage";
      case 6:
        return widget.isPolish ? "Demontaż" : "Disassembly";
      case 7:
        return widget.isPolish ? "Uśmiech klienta" : "Client's Smile";
      default:
        return "";
    }
  }

  String _getDescription(int number) {
    switch (number) {
      case 1:
        return widget.isPolish
            ? "Każdy projekt zaczyna się od rozmowy. Uważnie słuchamy Twoich potrzeb i celów, aby stworzyć idealny projekt. Nasz zespół biurowy dba o to, aby informacje trafiały dokładnie do kierownika stolarni, co pozwala na realizację projektu zgodnie z założeniami."
            : "We listen carefully to your needs to create the perfect design. Our team from theoffice relays the information to the carpentry shop manager. This ensures that weexecute the project as intended.";
      case 2:
        return widget.isPolish
            ? "Kierownik stolarni rozdziela zadania pomiędzy członków zespołu, zapewniając płynność działań. Pracownicy realizują swoje obowiązki z najwyższą precyzją, korzystając z nowoczesnego sprzętu, w tym maszyn CNC."
            : "The workshop manager assigns tasks among team members, ensuring smooth operations. Workers perform their duties with the utmost precision, using modern equipment, including CNC machines.";
      case 3:
        return widget.isPolish
            ? "Organizacja transportu to jedna z naszych mocnych stron. Dbamy o to, aby załadunek tirów przebiegał szybko i dokładnie, a towary były odpowiednio zapakowane i zabezpieczone na czas transportu."
            : "Transport organization is one of our strong points. We ensure quick and precise truck loading, with goods properly packed and secured for transport.";
      case 4:
        return widget.isPolish
            ? "Nasz zespół montażowy działa na miejscu wydarzenia targowego, z pełnym zaangażowaniem i pasją montując stoisko, które spełnia wszystkie oczekiwania klienta."
            : "Our assembly team works on-site at trade events, assembling booths with full commitment and passion to meet all client expectations.";
      case 5:
        return widget.isPolish
            ? "Po zakończeniu montażu, elementy stoiska są magazynowane w odpowiednich warunkach. Dbamy o porządek i zgodność z normami ekologicznymi, co pozwala na ponowne ich wykorzystanie w przyszłości."
            : "After assembly, booth components are stored in appropriate conditions. We ensure cleanliness and compliance with ecological standards, enabling their reuse in the future.";
      case 6:
        return widget.isPolish
            ? "Po zakończeniu wydarzenia nasz zespół przystępuje do demontażu. Wszystkie prace są prowadzone z najwyższą starannością, pozostawiając miejsce w nienagannym stanie."
            : "After the event, our team begins disassembly. All work is carried out with the utmost care, leaving the site in impeccable condition.";
      case 7:
        return widget.isPolish
            ? "Najlepszym podsumowaniem naszej pracy jest uśmiech zadowolonego klienta oraz ciepłe słowa uznania. To dla nas najcenniejsza nagroda, która motywuje nas do dalszego działania."
            : "The best summary our work is the smile of a satisfied client and warm words ofappreciation. This is the most valuable reward that motivates us for the future.";
      default:
        return "";
    }
  }

  String _getImagePath(int number) {
    return 'assets/Work/${[
      'Rozmowa',
      'Podzial',
      'Transport',
      'Montaz',
      'Magazyn',
      'Demontaz',
      'Usmiech'
    ][number - 1]}.png';
  }
}
