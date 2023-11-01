import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustumTextField extends StatefulWidget {
  final String icon;
  final String label;
  final String hint;
  final String errorLabel;
  final bool isSvg;
  final bool obscure;
  final bool readOnly;
  final bool hasCountryCode;
  final bool isDropDown;
  final TextStyle style;
  bool validate;
  final TextInputType inputType;
  final int? maxLength;
  final int? maxLines;
  final int? errorMaxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onClear;
  final TextEditingController? controller;
  GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  final List<TextInputFormatter>? inputFormatters;

  CustumTextField({
    Key? key,
    this.isSvg = true,
    this.readOnly = false,
    this.obscure = false,
    this.validate = false,
    this.hasCountryCode = false,
    this.isDropDown = false,
    this.maxLength,
    this.inputFormatters,
    this.errorMaxLines,
    required this.hint,
    this.controller,
    this.onTap,
    this.maxLines,
    this.focusNode,
    this.nextFocus,
    this.style = const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
    this.onChanged,
    this.onClear,
    this.errorLabel = "error",
    this.icon = "",
    required this.inputType,
    required this.label,
  }) : super(key: key);

  @override
  State<CustumTextField> createState() => _CustumTextFieldState();
}

class _CustumTextFieldState extends State<CustumTextField> {
  bool _isVisiblePassword = false;

  void updatePasswordStatus() {
    setState(() {
      _isVisiblePassword = !_isVisiblePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: TextField(
                focusNode: widget.focusNode,
                onTap: widget.onTap,
                controller: widget.controller,
                readOnly: widget.readOnly,
                inputFormatters: widget.inputFormatters,
                maxLength: widget.maxLength,
                // ignore: deprecated_member_use
                toolbarOptions: ToolbarOptions(
                  copy: widget.inputType != TextInputType.visiblePassword,
                  cut: widget.inputType != TextInputType.visiblePassword,
                  paste: widget.inputType != TextInputType.visiblePassword,
                  selectAll: widget.inputType != TextInputType.visiblePassword,
                ),
                textCapitalization: widget.inputType == TextInputType.name
                    ? TextCapitalization.words
                    : TextCapitalization.none,
                onChanged: (value) {
                  widget.onChanged?.call(value);

                  if (value.isNotEmpty && widget.validate) {
                    setState(() {
                      widget.validate = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.only(bottom: 12, left: 5),
                  errorStyle: const TextStyle(),
                  errorText: widget.validate ? widget.errorLabel : null,
                  errorMaxLines: widget.errorMaxLines,
                  isDense: true,
                  counterText: '',
                  hintText: widget.hint,
                  labelText: widget.label,
                ),
                maxLines: widget.maxLines,
                style: widget.style,
                keyboardType: widget.inputType,
                obscureText: widget.obscure
                    ? _isVisiblePassword
                        ? false
                        : true
                    : false,
                textInputAction:
                    widget.nextFocus != null ? TextInputAction.next : null,
                onSubmitted: widget.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String hint;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

  const SearchTextField(
      {Key? key,
      this.onChanged,
      required this.hint,
      required this.controller,
      this.inputFormatters})
      : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        contentPadding: const EdgeInsets.only(top: 5),
        isDense: true,
        hintText: widget.hint,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.search_sharp,
            color: Colors.black,
            size: 18,
          ),
        ),
        suffixIcon: widget.controller.text.isNotEmpty
            ? SizedBox(
                width: 25,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        widget.controller.text = '';
                        widget.onChanged?.call('');
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16))),
                    ),
                  ],
                ),
              )
            : const SizedBox(
                width: 0,
                height: 0,
              ),
      ),
    );
  }
}
