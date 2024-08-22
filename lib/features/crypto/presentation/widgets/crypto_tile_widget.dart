import 'package:coin_trackr/core/common/theme/app_colors.dart';
import 'package:coin_trackr/core/common/utils/styles.dart';
import 'package:coin_trackr/core/data/entities/crypto.dart';
import 'package:flutter/material.dart';

class CryptoTileWidget extends StatefulWidget {
  final Crypto crypto;
  final void Function(Crypto crypto) onCheck;
  final bool isFavorite;

  const CryptoTileWidget({
    super.key,
    required this.crypto,
    required this.onCheck,
    required this.isFavorite,
  });

  @override
  State<CryptoTileWidget> createState() => _CryptoTileWidgetState();
}

class _CryptoTileWidgetState extends State<CryptoTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 10,
            )
          ]),
      child: Row(
        children: [
          _buildCryptoImage(),
          const SizedBox(width: 15),
          _buildCryptoInfo(),
          _buildFavorite()
        ],
      ),
    );
  }

  Widget _buildCryptoImage() {
    return Image.network(
      widget.crypto.image,
      height: 25,
    );
  }

  Widget _buildCryptoInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.crypto.name,
            style: TextStyles.pBody1.bold,
            textAlign: TextAlign.left,
          ),
          Text(
            widget.crypto.symbol,
            style: TextStyles.pBody2,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 5),
          Text(
            "\$${widget.crypto.price}",
            style: TextStyles.pBody2.bold,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildFavorite() {
    return InkWell(
      onTap: () => widget.onCheck(widget.crypto),
      child: widget.isFavorite
          ? const Icon(
              Icons.star,
              color: AppColors.starColor,
            )
          : const Icon(
              Icons.star_border,
              color: AppColors.starColor,
            ),
    );
  }
}
