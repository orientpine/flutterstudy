// ignore_for_file: prefer_const_constructors

import 'package:calenderscheduler/component/custom_text_field.dart';
import 'package:calenderscheduler/database/drift_database.dart';
import 'package:calenderscheduler/model/category_color.dart';
import 'package:calenderscheduler/theme/color_schemes.g.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final int? scheduleId;
  const ScheduleBottomSheet({
    required this.selectedDate,
    this.scheduleId,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder<Schedule>(
          future: widget.scheduleId == null
              ? null
              : GetIt.I<LocalDatabase>().getSchedulesById(widget.scheduleId!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '스케줄을 불러올 수 없습니다.',
                ),
              );
            }
            if (snapshot.connectionState != ConnectionState.none &&
                !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && startTime == null) {
              startTime = snapshot.data!.startTime;
              endTime = snapshot.data!.endTime;
              content = snapshot.data!.content;
              selectedColorId = snapshot.data!.colorID;
            }
            return SafeArea(
              child: Container(
                color: lightColorScheme.background,
                height: (MediaQuery.of(context).size.height) / 2 + bottomInset,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: bottomInset,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 16,
                      bottom: 0,
                    ),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          _Time(
                            onStartSaved: onStartSaved,
                            onEndSaved: onEndSaved,
                            startInitialValue: startTime?.toString() ?? "",
                            endInitialValue: endTime?.toString() ?? "",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _Contents(
                            onTextSaved: onTextSaved,
                            initialValue: content ?? "",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder<List<CategoryColor>>(
                            future:
                                GetIt.I<LocalDatabase>().getCategoryColors(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  selectedColorId == null &&
                                  snapshot.data!.isNotEmpty) {
                                selectedColorId = snapshot.data![0].id;
                              }
                              return _ColorPicker(
                                colors: snapshot.hasData ? snapshot.data! : [],
                                selectedColorId: selectedColorId,
                                colorIdSetter: (int id) {
                                  setState(
                                    () {
                                      selectedColorId = id;
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          _SaveButton(
                            onPressed: onSavePressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void onStartSaved(String? val) {
    startTime = int.parse(val!);
  }

  void onEndSaved(String? val) {
    endTime = int.parse(val!);
  }

  void onTextSaved(String? val) {
    content = val;
  }

  void onSavePressed() async {
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (widget.scheduleId == null) {
        await GetIt.I<LocalDatabase>().createSchedule(
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorID: Value(selectedColorId!),
          ),
        );
      } else {
        await GetIt.I<LocalDatabase>().updateScheduleById(
          widget.scheduleId!,
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorID: Value(selectedColorId!),
          ),
        );
      }

      if (!mounted) return;
      Navigator.of(context).pop();
    } else {}
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String startInitialValue;
  final String endInitialValue;
  const _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    required this.startInitialValue,
    required this.endInitialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // text field는 row일 때 항상 size를 정해줘야한다!s
        Expanded(
          child: CustomTextField(
            title: '시작 시간',
            isTime: true,
            onSaved: onStartSaved,
            initialValue: startInitialValue,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: CustomTextField(
            title: '종료 시간',
            isTime: true,
            onSaved: onEndSaved,
            initialValue: endInitialValue,
          ),
        ),
      ],
    );
  }
}

class _Contents extends StatelessWidget {
  final FormFieldSetter<String> onTextSaved;
  final String initialValue;
  const _Contents({
    required this.onTextSaved,
    required this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        title: '내용',
        isTime: false,
        onSaved: onTextSaved,
        initialValue: initialValue,
      ),
    );
  }
}

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;
  const _ColorPicker({
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Wrap(
        spacing: 8.0,
        children: colors
            .map(
              (e) => GestureDetector(
                onTap: () {
                  colorIdSetter(e.id);
                },
                child: renderColor(
                  e,
                  selectedColorId == e.id,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Color(
          int.parse(
            'FF${color.hexCode}',
            radix: 16,
          ),
        ),
        border: isSelected
            ? Border.all(
                color: Colors.black,
                width: 4.0,
              )
            : null,
        shape: BoxShape.circle,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              '저장하기',
            ),
          ),
        ),
      ],
    );
  }
}
