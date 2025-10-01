import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:trackrinatr/app/theme.dart';

class ProUpgradeScreen extends StatefulWidget {
  const ProUpgradeScreen({super.key});

  @override
  State<ProUpgradeScreen> createState() => _ProUpgradeScreenState();
}

class _ProUpgradeScreenState extends State<ProUpgradeScreen> {
  final InAppPurchase _iap = InAppPurchase.instance;
  bool _available = false;
  List<ProductDetails> _products = [];
  late Stream<List<PurchaseDetails>> _purchaseStream;

  @override
  void initState() {
    super.initState();
    _purchaseStream = _iap.purchaseStream;
    _initStore();
  }

  Future<void> _initStore() async {
    _available = await _iap.isAvailable();
    if (!_available) return;

    // Define your product IDs from App Store / Play Console
    const ids = {'pro_monthly', 'pro_yearly'};

    final response = await _iap.queryProductDetails(ids);
    if (response.error != null) {
      debugPrint("IAP Error: ${response.error}");
      return;
    }
    if (!mounted) return;

    setState(() {
      _products = response.productDetails;
    });
  }

  void _buy(ProductDetails product) {
    final purchaseParam = PurchaseParam(productDetails: product);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Paper++ Pro", style: AppText.heading),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Keep it simple, but smarter.",
              style: AppText.subheading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            _FeatureTile(
              icon: Icons.show_chart,
              text: "Progress graphs — See how your lifts change over time",
            ),
            _FeatureTile(
              icon: Icons.backup,
              text: "Export & backup — Keep your data safe, share if you want",
            ),
            _FeatureTile(
              icon: Icons.palette,
              text: "Customization — Plate/bar profiles, themes",
            ),
            _FeatureTile(
              icon: Icons.block,
              text: "No ads — A cleaner notebook",
            ),

            const Spacer(),

            if (_products.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: _products.map((p) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentAlt,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _buy(p),
                      child: Text(
                        "${p.title}\n${p.price}",
                        textAlign: TextAlign.center,
                        style: AppText.subheading,
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accentAlt, size: 28),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppText.body)),
        ],
      ),
    );
  }
}
