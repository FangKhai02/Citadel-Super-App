import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_document_image_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:citadel_super_app/project_widget/selection/app_checkbox.dart';
import 'package:citadel_super_app/screen/universal/component/sign_authories_widget.dart';
import 'package:citadel_super_app/screen/universal/component/signature_container.dart';
import 'package:flutter/widgets.dart';

class AppForm extends StatefulWidget {
  final Widget child;

  const AppForm({super.key, required this.child});

  @override
  State<AppForm> createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  Map<String, dynamic> formData = {};

  Future<void> validate({
    required Function(Map<String, dynamic> formData) onSuccess,
    Function(BuildContext firstErrorContext)? onFailed,
  }) async {
    // Clear previous form data to avoid stale values
    formData = {};

    BuildContext? firstErrorContext;
    bool isValid = true;
    print('[AppForm.validate] Starting validation');
    print('[AppForm.validate] this.context: $context');
    print('[AppForm.validate] this.widget.child runtimeType: ${widget.child.runtimeType}');

    context.visitChildElements((parent) {
      print('[AppForm.validate] Visiting parent: ${parent.widget.runtimeType}');
      _visit(parent, onError: (context) {
        print('[AppForm.validate] Error callback triggered');
        isValid = false;

        firstErrorContext ??= context;
      });
    });

    print('[AppForm.validate] After visit - isValid: $isValid, formData: $formData');

    if (isValid) {
      print('[AppForm.validate] Calling onSuccess');
      await onSuccess(formData);
    } else {
      print('[AppForm.validate] Calling onFailed');
      onFailed?.call(firstErrorContext!) ??
          Scrollable.ensureVisible(
            firstErrorContext!,
            duration: const Duration(milliseconds: 300),
            alignment: 0.5,
          );
    }
  }

  void setError({required String fieldKey, String? errorMsg}) {
    context.visitChildElements((parent) {
      _setError(parent, fieldKey: fieldKey, errorMsg: errorMsg);
    });
  }

  void validateFormButton() {
    bool isAllFilled = true;
    context.visitChildElements((parent) {
      _visit(parent, onError: (_) {
        isAllFilled = false;
      }, validateButton: true);
    });

    print('[AppForm] validateFormButton: isAllFilled=$isAllFilled');

    context.visitChildElements((parent) {
      _validateButton(parent, isAllFilled);
    });
  }

  /// Visit each of the children of the parent element
  /// [validateButton]
  void _visit(
    Element parent, {
    required Function(BuildContext context) onError,
    bool validateButton = false,
  }) {
    print('[AppForm._visit] parent: ${parent.widget.runtimeType}, validateButton=$validateButton');
    parent.visitChildren((element) async {
      print('[AppForm._visit] element: ${element.widget.runtimeType}');
      if (element.widget is AppTextFormField) {
        final state =
            (element as StatefulElement).state as AppTextFormFieldState;

        if (state.widget.isRequired) {
          if (validateButton) {
            final isValid = state.hasValue;
            print('[AppForm._visit] AppTextFormField ${state.widget.fieldKey}: hasValue=$isValid, isRequired=true');
            if (!isValid) {
              onError(context);
            }
          } else {
            final isValid = state.validate();
            print('[AppForm._visit] AppTextFormField ${state.widget.fieldKey}: validate()=$isValid');
            if (!isValid) {
              onError(state.context);
            } else {
              formData[state.widget.fieldKey] = state.onSaved();
            }
          }
        } else {
          formData[state.widget.fieldKey] = state.onSaved();
        }
      } else if (element.widget is AppDropdown) {
        final state = (element as StatefulElement).state as AppDropdownState;
        print('[AppForm._visit] AppDropdown ${state.widget.fieldKey}: selectedItem=${state.selectedItem?.value}, text=${state.textEditingController.text}');

        if (validateButton) {
          if (!state.validate()) {
            print('[AppForm._visit] AppDropdown validation failed');
            onError(context);
          }
        } else {
          final isValid = state.validate();

          if (!isValid) {
            print('[AppForm._visit] AppDropdown ${state.widget.fieldKey}: validate()=$isValid');
            onError(state.context);
          } else {
            formData[state.widget.fieldKey] = state.onSaved();
          }
        }
      } else if (element.widget is AppCheckbox) {
        final state = (element as StatefulElement).state as AppCheckboxState;

        if (validateButton) {
          if (!state.validate()) {
            onError(context);
          }
        } else {
          final isValid = state.validate();

          if (!isValid) {
            onError(state.context);
          } else {
            formData[state.widget.fieldKey] = state.onSaved();
          }
        }
      } else if (element.widget is AddressDetailsForm) {
        final state =
            (element as StatefulElement).state as AddressDetailsFormState;

        if (validateButton) {
          if (!state.validate()) {
            onError(context);
          }
        } else {
          bool isValid = true;

          _visit(element, onError: (context) {
            onError(context);
            isValid = false;
          });

          if (isValid) {
            if (state.widget.fieldKey != null) {
              formData[state.widget.fieldKey!] = state.onSaved();
            } else {
              formData[AppFormFieldKey.addressDetailsFormKey] = state.onSaved();
            }
          }
        }
      } else if (element.widget is AppMobileFormField) {
        final state =
            (element as StatefulElement).state as AppMobileFormFieldState;

        if (validateButton) {
          if (!state.validate()) {
            onError(context);
          }
        } else {
          bool isValid = true;

          _visit(element, onError: (context) {
            onError(context);
            isValid = false;
          });

          if (isValid) {
            formData[AppFormFieldKey.countryCodeKey] =
                state.onSaved().countryCode;
            formData[AppFormFieldKey.mobileNumberKey] =
                state.onSaved().mobileNumber;
          }
        }
      } else if (element.widget is AppDocumentImageFormField) {
        final docField = element.widget as AppDocumentImageFormField;
        print('[AppForm._visit] AppDocumentImageFormField fieldKey=${docField.fieldKey}');
        final state = (element as StatefulElement).state
            as AppDocumentImageFormFieldState;

        if (validateButton) {
          state.validateImage();

          if ((docField.frontImage == null) ||
              (docField.backImage == null)) {
            print('[AppForm._visit] AppDocumentImageFormField: images missing');
            onError(context);
          }
        } else {
          final isValid = state.validateImage();
          print('[AppForm._visit] AppDocumentImageFormField: validateImage()=$isValid');

          if (!isValid) {
            onError(state.context);
          } else {
            formData[AppFormFieldKey.documentFrontImageKey] =
                state.onSaved().frontImage;
            formData[AppFormFieldKey.documentBackImageKey] =
                state.onSaved().backImage;
          }
        }
      } else if (element.widget is AppUploadDocumentWidget) {
        final state =
            (element as StatefulElement).state as AppUploadDocumentWidgetState;

        if (validateButton) {
          state.validate();

          if (!state.validate()) {
            onError(context);
          }
        } else {
          bool isValid = state.validate();

          if (isValid) {
            formData[AppFormFieldKey.proofDocKey] = state.onSaved();
          } else {
            onError(state.context);
          }
        }
      } else if (element.widget is SignAuthoriesWidget) {
        final state = (element as StatefulElement).state as SignWidgetState;

        if (validateButton) {
          if (!state.validate()) {
            onError(context);
          }
        } else {
          final isValid = state.validate();

          if (!isValid) {
            onError(state.context);
          } else {
            formData[state.widget.fieldKey] = state.onSaved();
          }
        }
      } else if (element.widget is SignatureContainer) {
        final state =
            (element as StatefulElement).state as SignatureContainerState;

        if (!validateButton) {
          if (state.widget.signatureController.isEmpty) {
            onError(state.context);
          } else {
            formData[state.widget.key.toString()] =
                state.widget.signatureController.value.isNotEmpty;
          }
        }
      } else {
        _visit(element, onError: onError, validateButton: validateButton);
      }
    });
  }

  void _setError(Element parent, {required String fieldKey, String? errorMsg}) {
    parent.visitChildren((element) {
      if (element.widget is AppTextFormField) {
        final state =
            (element as StatefulElement).state as AppTextFormFieldState;
        if (state.widget.fieldKey == fieldKey) {
          state.setError(errorMsg ?? 'Invalid Value');
        }
      } else if (element.widget is AppDocumentImageFormField) {
        final state = (element as StatefulElement).state
            as AppDocumentImageFormFieldState;
        if (state.widget.fieldKey == fieldKey) {
          state.setError(true);
        }
      } else if (element.widget is AppUploadDocumentWidget) {
        final state =
            (element as StatefulElement).state as AppUploadDocumentWidgetState;
        if (state.widget.fieldKey == fieldKey) {
          state.setError(errorMsg ?? 'Invalid Value');
        }
      } else {
        _setError(element, fieldKey: fieldKey, errorMsg: errorMsg);
      }
    });
  }

  void _validateButton(Element parent, bool isEnabled) {
    parent.visitChildren((element) {
      if (element.widget is PrimaryButton &&
          element.widget.key ==
              const Key(AppFormFieldKey.primaryButtonValidateKey)) {
        final state = (element as StatefulElement).state as PrimaryButtonState;
        state.setEnable(isEnabled);
      } else {
        _validateButton(element, isEnabled);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
