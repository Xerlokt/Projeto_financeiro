import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Text(
                    // ignore: unnecessary_null_comparison
                    _selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        : 'Data: ${DateFormat('d/M/y').format(_selectedDate)}',
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: _submitForm,
                  child: const Text('Nova Transação'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}