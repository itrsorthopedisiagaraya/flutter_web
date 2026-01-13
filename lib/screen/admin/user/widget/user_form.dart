import 'package:flutter/material.dart';

import '../../helper.dart';

class UserForm extends StatefulWidget {
  final Map<String, String>? initialData;
  final void Function(Map<String, String> data) onSubmit;

  const UserForm({super.key, this.initialData, required this.onSubmit});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  String role = 'user';

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.initialData?['name']);
    emailCtrl = TextEditingController(text: widget.initialData?['email']);
    role = widget.initialData?['role'] ?? 'user';
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit({
      'name': nameCtrl.text.trim(),
      'email': emailCtrl.text.trim(),
      'role': role,
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Padding(
      padding: EdgeInsets.only(left: isDesktop ? 60.0 : 16.0),
      child: Form(
        key: _formKey,
        child: isDesktop ? _desktopLayout() : _mobileLayout(),
      ),
    );
  }

  // ---------------- LAYOUTS ----------------

  Widget _mobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _nameField(),
        const SizedBox(height: 16),
        _emailField(),
        const SizedBox(height: 16),
        _roleField(),
        const SizedBox(height: 24),
        _submitButton(),
      ],
    );
  }

  Widget _desktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _nameField()),
            const SizedBox(width: 16),
            Expanded(child: _emailField()),
            const SizedBox(width: 16),
            Expanded(child: _roleField()),
          ],
        ),
        const SizedBox(height: 16),
        Align(alignment: Alignment.centerLeft, child: _submitButton()),
      ],
    );
  }

  // ---------------- FIELDS ----------------

  Widget _nameField() => TextFormField(
    controller: nameCtrl,
    decoration: const InputDecoration(
      labelText: 'Name',
      border: OutlineInputBorder(),
    ),
    validator: (v) => v!.isEmpty ? 'Required' : null,
  );

  Widget _emailField() => TextFormField(
    controller: emailCtrl,
    decoration: const InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(),
    ),
    validator: (v) => v!.isEmpty ? 'Required' : null,
  );

  Widget _roleField() {
    return InkWell(
      onTap: () {
        showSearchablePicker(
          context,
          title: 'Select Role',
          items: const ['admin', 'user', 'manager'],
          selected: role,
          onSelected: (v) => setState(() => role = v),
        );
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Role',
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(role.isEmpty ? 'Select role' : role),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() => FilledButton.icon(
    icon: const Icon(Icons.save),
    label: const Text('Save'),
    onPressed: _submit,
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );
}
