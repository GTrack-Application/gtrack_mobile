import 'package:flutter/material.dart';

class GtinInformationScreen extends StatefulWidget {
  const GtinInformationScreen({super.key});

  @override
  State<GtinInformationScreen> createState() => _GtinInformationScreenState();
}

class _GtinInformationScreenState extends State<GtinInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https:\/\/gs1ksa.org\/backend\/images\/products\/649809d4d08141687685588.webp'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const BorderedRowWidget(value1: "GTIN", value2: "123"),
                  const BorderedRowWidget(value1: "Brand name", value2: "123"),
                  const BorderedRowWidget(
                      value1: "Product Description", value2: "123"),
                  const BorderedRowWidget(value1: "Image URL", value2: "123"),
                  const BorderedRowWidget(
                      value1: "Global Product Category", value2: "123"),
                  const BorderedRowWidget(value1: "Net Content", value2: "123"),
                  const BorderedRowWidget(
                      value1: "Country Of Sale", value2: "123"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BorderedRowWidget extends StatelessWidget {
  final String value1, value2;
  const BorderedRowWidget({
    super.key,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value1,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              value2,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
