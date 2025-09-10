import 'package:flutter/material.dart';
import 'package:teamfit/src/config/theme/custom_color.dart';
import 'package:teamfit/src/config/theme/custom_text.dart';
import 'dart:math' as math;

class TeamMemberProgressIcon extends StatelessWidget {
  final String? profileImageUrl;
  final String nickname;
  final String accumulatedTime;
  final double progress; // 0.0 ~ 1.0
  final double size;
  final bool showPlusN;
  final int? additionalCount;

  const TeamMemberProgressIcon({
    Key? key,
    this.profileImageUrl,
    required this.nickname,
    required this.accumulatedTime,
    required this.progress,
    this.size = 48.0,
    this.showPlusN = false,
    this.additionalCount,
  }) : super(key: key);

  Color _getProgressColor() {
    if (progress >= 0.8) {
      return Colors.green; // 80% 이상 - 초록색
    } else if (progress >= 0.4) {
      return Colors.orange; // 40-80% - 주황색
    } else {
      return Colors.red; // 40% 미만 - 빨간색
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: _buildProfileWithProgress(),
        ),
        const SizedBox(height: 4),
        if (!showPlusN) ...[
          Text(
            nickname,
            style: CustomText.Body_Heavy_XS_12.copyWith(
              color: CustomColor.gray_10,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            accumulatedTime,
            style: CustomText.Body_Light_XS_12.copyWith(
              color: CustomColor.gray_10,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildProfileWithProgress() {
    if (showPlusN && additionalCount != null) {
      return _buildPlusNIcon();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // 프로그레스 원형 배경
        SizedBox(
          width: size + 9,
          height: size + 9,
          child: CustomPaint(
            painter: CircularProgressPainter(
              progress: progress,
              progressColor: _getProgressColor(),
              backgroundColor: Colors.transparent,
              strokeWidth: 4.5,
            ),
          ),
        ),
        // 프로필 이미지
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColor.gray_90,
            image:
                profileImageUrl != null
                    ? DecorationImage(
                      image: NetworkImage(profileImageUrl!),
                      fit: BoxFit.cover,
                    )
                    : null,
          ),
          child:
              profileImageUrl == null
                  ? Icon(
                    Icons.person,
                    color: CustomColor.gray_60,
                    size: size * 0.6,
                  )
                  : null,
        ),
      ],
    );
  }

  Widget _buildPlusNIcon() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColor.gray_30,
      ),
      child: Center(
        child: Text(
          '+${additionalCount ?? 0}',
          style: CustomText.Label_Heavy_XS_12.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 배경 원 그리기
    final backgroundPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // 프로그레스 호 그리기
    if (progress > 0) {
      final progressPaint =
          Paint()
            ..color = progressColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round;

      final startAngle = -math.pi / 2; // 12시 방향부터 시작
      final sweepAngle = 2 * math.pi * progress;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
