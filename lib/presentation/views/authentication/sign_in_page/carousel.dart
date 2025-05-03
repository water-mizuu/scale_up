import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/sign_in_page/sign_in_page_bloc.dart";
import "package:scale_up/utils/extensions/border_color_extension.dart";

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<CardContentAttribute> attributes = [
    CardContentAttribute(
      image: Image.asset("assets/illustrations/topic.png"),
      title: "ScaleUp",
      description: "A unit conversion learning application.",
    ),
    CardContentAttribute(
      image: Image.asset("assets/illustrations/lessons.png"),
      title: "Numerous Lessons",
      description:
          "Enter in short lessons of step-by-step procedures on how to convert various real-world units",
    ),
    CardContentAttribute(
      image: Image.asset("assets/illustrations/quizzes.png"),
      title: "Interactive Quizzes",
      description: "Strengthen and Retain your learnings with tailored and replayable quizzes.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged:
                  (pageposition) =>
                      context.read<SignInPageBloc>().add(LoginPageFormSwiped(pageposition)),
              itemCount: attributes.length,
              itemBuilder: (context, index) {
                return CarouselCard(attribute: attributes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.attribute});

  final CardContentAttribute attribute;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardContent(title: attribute.title, description: attribute.description),
        Expanded(child: Padding(padding: EdgeInsets.all(56.0), child: attribute.image)),
      ],
    );
  }
}

class Pagination extends StatelessWidget {
  const Pagination({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8.0,
      children: [PaginationCircle(p: 0), PaginationCircle(p: 1), PaginationCircle(p: 2)],
    );
  }
}

class PaginationCircle extends StatelessWidget {
  const PaginationCircle({super.key, required this.p});

  final int p;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInPageBloc, SignInPageState>(
      builder: (context, state) {
        if (state.carouselPosition == p) {
          return Container(
            height: 8,
            width: 16,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
          );
        } else {
          return Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.white.borderColor,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
          );
        }
      },
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        spacing: 4.0,
        children: [
          Text(title, style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
          Text(description, style: TextStyle(fontSize: 12.0), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class CardContentAttribute {
  const CardContentAttribute({
    required this.image,
    required this.title,
    required this.description,
  });
  final Image image;
  final String title;
  final String description;
}
