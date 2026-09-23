
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/errors/providers/reload_user_error.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/errors/widgets/reload_user_error_widget.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/errors/widgets/resend_email_verification_error_widget.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/providers/timer_provider_sending_email_verification.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/service/verify_email_service.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxOfVerification extends ConsumerWidget {
  const BoxOfVerification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon badge
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.outline,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_unread_rounded,
              color: Colors.orange,
              size: 28,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            'Verify your email',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            "We've sent a verification link to your email. Click the link to verify your account.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              height: 1.4,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),

          // Confirm button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                unawaited(ref.read(verifyEmailServiceProvider.notifier).reloadUser());
              },
              borderRadius: BorderRadius.circular(14),
              splashColor: const Color.fromARGB(40, 255, 255, 255),
              child: Ink(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "I've verified my email",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ReloadUserErrorsWidget(),
          const SizedBox(height: 14),
 
          // Resend link
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 13,
                color: colorScheme.onSurfaceVariant,
              ),
              children: [
                const TextSpan(text: "Didn't receive a verification link? "),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: GestureDetector(
                    onTap: () {
                      unawaited(ref.read(verifyEmailServiceProvider.notifier).resendEmail());
                    },
                    child:
                    Consumer(
                      builder:(context, ref, child) {
                      final timer = ref.watch(timerProviderSendingEmailVer);
                      if(timer == null){
                     return Text(
                      'Resend link',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                      } 
                      else{
                        return Text(
                      'Resend link    $timer second',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    );

                      }
                      }
                    )
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4,),
          ResendEmailVerificationErrorsWidget()
        ],
        
      ),
    );
  }
}