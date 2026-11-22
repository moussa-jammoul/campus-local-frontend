import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
class ProjectInfoFooter extends StatelessWidget {
  const ProjectInfoFooter({super.key});

  static const _githubUrl = 'https://github.com/moussa-jammoul/campus-local-frontend';

  Future<void> _openGithub() async {
    
    final uri = Uri.parse(_githubUrl);
    if (await canLaunchUrl(uri)) {
      
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontSize: 9,
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        );

    final linkStyle = baseStyle?.copyWith(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
      decoration: TextDecoration.underline,
      
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: baseStyle,
          children: [
            const TextSpan(
              text: 'the project is a free and open source '
                  'by the author Moussa Jammoul, for more information '
                  'of the project and collaboration, check: ',
            ),
            TextSpan(
              text: _githubUrl,
              style: linkStyle,
              recognizer: TapGestureRecognizer()..onTap = _openGithub,
            ),
          ],
        ),
      ),
    );
  }
}