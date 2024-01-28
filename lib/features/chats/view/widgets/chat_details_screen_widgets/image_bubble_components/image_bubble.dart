
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/functions/global_functions.dart';
import 'package:whats_app_clone/data/model/chat_model/message_model.dart';

import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../../../../view_model/chat_details_cubit/image_bubble_cubit/image_bubble_cubit.dart';
import '../custom_bubble_parent.dart';

part 'error_image_handling_component.dart';

part 'image_bubble_body.dart';

class ImageBubble extends StatefulWidget {
  const ImageBubble({
    super.key,
    required this.isTheSender,
    required this.themeColors,
    required this.isFirstMessage,
    required this.backgroundBlendMode,
    required this.messageModel,
    required this.hisPhoneNumber,
  });

  final MessageModel messageModel;
  final String hisPhoneNumber;
  final bool isTheSender;
  final bool isFirstMessage;
  final ThemeColors themeColors;
  final BlendMode backgroundBlendMode;

  @override
  State<ImageBubble> createState() => _ImageBubbleState();
}

class _ImageBubbleState extends State<ImageBubble> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ImageBubbleCubit>(context).checkIfFileExistsAndPlayOrDownload(
      imageUrl:  widget.messageModel.message,
      hisPhoneNumber: widget.hisPhoneNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ErrorImageHandlingComponent(
      child: CustomBubbleParent(
        isFirstMessage: widget.isFirstMessage,
        themeColors: widget.themeColors,
        isTheSender: widget.isTheSender,
        widgetBubbleBody: _ImageBubbleBodyComponent(
          isTheSender: widget.isTheSender,
          themeColors: widget.themeColors,
          image: widget.messageModel.message,
          time: widget.messageModel.time,
          backgroundBlendMode: widget.backgroundBlendMode,
          hisPhoneNumber: widget.hisPhoneNumber,
        ),
      ),
    );
  }
}
