// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:demo/components/avatar_use_case.dart' as _i2;
import 'package:demo/components/button_use_case.dart' as _i3;
import 'package:demo/components/callout_use_case.dart' as _i4;
import 'package:demo/components/card_use_case.dart' as _i5;
import 'package:demo/components/checkbox_use_case.dart' as _i6;
import 'package:demo/components/radio_use_case.dart' as _i7;
import 'package:demo/components/spinner_use_case.dart' as _i8;
import 'package:demo/components/switch_use_case.dart' as _i9;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookFolder(
        name: 'avatar',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'RxAvatar',
            useCase: _i1.WidgetbookUseCase(
              name: 'Avatar Component',
              builder: _i2.buildAvatarUseCase,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'button',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'RxButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Button Component',
              builder: _i3.buildButtonUseCase,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'callout',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'RxCallout',
            useCase: _i1.WidgetbookUseCase(
              name: 'Callout Component',
              builder: _i4.buildCalloutUseCase,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'card',
        children: [
          _i1.WidgetbookComponent(
            name: 'RxCard',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Card Component',
                builder: _i5.buildCard,
              ),
              _i1.WidgetbookUseCase(
                name: 'With button',
                builder: _i5.buildRadioUseCase,
              ),
            ],
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'checkbox',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'RxCheckbox',
            useCase: _i1.WidgetbookUseCase(
              name: 'Checkbox Component',
              builder: _i6.buildCheckboxUseCase,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'radio',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'RxRadio',
            useCase: _i1.WidgetbookUseCase(
              name: 'Radio Component',
              builder: _i7.buildRadioUseCase,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'spinner',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'RxSpinner',
            useCase: _i1.WidgetbookUseCase(
              name: 'Spinner Component',
              builder: _i8.buildSpinnerUseCase,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'switch',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'RxSwitch',
            useCase: _i1.WidgetbookUseCase(
              name: 'Switch Component',
              builder: _i9.buildSwitchUseCase,
            ),
          )
        ],
      ),
    ],
  )
];
