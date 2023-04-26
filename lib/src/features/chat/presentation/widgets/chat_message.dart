import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:omnisense/src/app/assets.dart';
import 'package:omnisense/src/extensions/build_context.dart';
import 'package:omnisense/src/extensions/num.dart';
import 'package:omnisense/src/features/chat/chat.dart';

const solarizedDarkTheme = {
  'comment': TextStyle(color: Color(0xff93a1a1)),
  'quote': TextStyle(color: Color(0xff93a1a1)),
  'variable': TextStyle(color: Color(0xffd33682)),
  'template-variable': TextStyle(color: Color(0xffd33682)),
  'tag': TextStyle(color: Color(0xff268bd2)),
  'name': TextStyle(color: Color(0xff268bd2)),
  'selector-id': TextStyle(color: Color(0xff2aa198)),
  'selector-class': TextStyle(color: Color(0xff2aa198)),
  'regexp': TextStyle(color: Color(0xffb58900)),
  'deletion': TextStyle(color: Color(0xffb58900)),
  'number': TextStyle(color: Color(0xff859900)),
  'built_in': TextStyle(color: Color(0xff859900)),
  'builtin-name': TextStyle(color: Color(0xff859900)),
  'literal': TextStyle(color: Color(0xff2aa198)),
  'type': TextStyle(color: Color(0xff2aa198)),
  'params': TextStyle(color: Color(0xffb58900)),
  'meta': TextStyle(color: Color(0xff268bd2)),
  'link': TextStyle(color: Color(0xff2aa198)),
  'attribute': TextStyle(color: Color(0xff2aa198)),
  'string': TextStyle(color: Color(0xff2aa198)),
  'symbol': TextStyle(color: Color(0xff6c71c4)),
  'bullet': TextStyle(color: Color(0xff6c71c4)),
  'addition': TextStyle(color: Color(0xff2aa198)),
  'title': TextStyle(color: Color(0xff268bd2)),
  'section': TextStyle(color: Color(0xff268bd2)),
  'keyword': TextStyle(color: Color(0xff859900)),
  'selector-tag': TextStyle(color: Color(0xffb58900)),
  'root': TextStyle(
    backgroundColor: Color(0xff839496),
    color: Color(0xff839496),
  ),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
  'strong': TextStyle(fontWeight: FontWeight.bold),
};

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.data,
  });
  final MessageData data;
  @override
  Widget build(BuildContext context) {
    final generator = MarkdownGenerator(
      config: MarkdownConfig(
        configs: [
          PreConfig(
            theme: solarizedDarkTheme,
            wrapper: (child, code) => Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(LineIcons.copy),
                      onPressed: () {},
                    ),
                  ],
                ),
                child,
              ],
            ),
            decoration: BoxDecoration(
              color: const Color(0xff839496).withOpacity(0.7),
              borderRadius: BorderRadius.circular(14),
            ),
            language: 'kotlin',
            textStyle: GoogleFonts.firaCode(
              fontSize: 10,
            ),
          ),
          CodeConfig(
            style: GoogleFonts.firaCode(
              fontSize: 14,
            ),
          ),
          PConfig(
            textStyle: GoogleFonts.prociono(
                //color: context.colorScheme.primary,
                // fontWeight: FontWeight.w200,
                ),
          ),
          LinkConfig(
            style: TextStyle(
              color: context.colorScheme.primary,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w200,
            ),
            onTap: (url) {},
          )
        ],
      ),
    );
    final widgets = generator.buildWidgets(data.message);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: !data.isMe ? context.colorScheme.primaryContainer : null,
          // borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.vGap,
              if (!data.isMe)
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(Assets.assetsImagesHappy),
                    ),
                    Text(
                      data.sender,
                      style: GoogleFonts.playfairDisplay(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ...widgets
            ],
          ),
        ),
      ),
    );
  }
}
