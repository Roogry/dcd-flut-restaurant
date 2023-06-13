import 'package:dcd_flut_restaurant/common/state_enum.dart';
import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/provider/restaurant_detail_provider.dart';
import 'package:dcd_flut_restaurant/provider/review_add_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WriteReviewPage extends StatelessWidget {
  static const routeName = '/write_review';

  WriteReviewPage({super.key, required this.restaurant});

  Restaurant restaurant;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.adaptive.arrow_back,
              color: blackText,
            ),
          ),
        ),
        title: Text(
          'Tulis Review',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Hero(
                tag: restaurant.pictureId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  restaurant.name ?? '-',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/pin_fill.svg',
                      height: 10,
                      width: 10,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.city ?? '-',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: secondaryText,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 56),
              _textField(
                hintText: 'Nama',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _textField(
                hintText: 'Ceritakan reviewmu',
                controller: _reviewController,
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              _buttonSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required String hintText,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: blackText,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: placeholderText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: primaryBackground,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kolom tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit(BuildContext context) {
    return Consumer<ReviewAddProvicer>(
      builder: (context, state, _) {
        return ElevatedButton(
          onPressed: state.state == ResultState.loading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    var data = {
                      'id': restaurant.id,
                      'name': _nameController.text,
                      'review': _reviewController.text,
                    };

                    state.submitReview(data).then((_) {
                      if (state.state == ResultState.error) {
                        debugPrint(state.message);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      } else {
                        _nameController.clear();
                        _reviewController.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Review berhasil ditambahkan'),
                          ),
                        );

                        Provider.of<RestaurantDetailProvider>(context,
                                listen: false)
                            .fetchRestaurantDetail(restaurant.id!);
                        Navigator.pop(context);
                      }
                    });
                  }
                },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: state.state == ResultState.loading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Kirim Review',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
        );
      },
    );
  }
}
