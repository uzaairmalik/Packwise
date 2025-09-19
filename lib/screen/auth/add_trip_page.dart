import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/trip.dart'; // <-- fixed import

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});
  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _dest = TextEditingController();
  DateTime? _start, _end;
  final List<String> _activities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Trip')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _form,
          child: ListView(children: [
            TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Title'), validator: (v)=>v==null||v.isEmpty?'Required':null),
            const SizedBox(height: 8),
            TextFormField(controller: _dest, decoration: const InputDecoration(labelText: 'Destination (city)'), validator: (v)=>v==null||v.isEmpty?'Required':null),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: Text(_start==null?'Start date':_start!.toLocal().toString().split(' ')[0])),
              TextButton(onPressed: () async {
                final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 365)), lastDate: DateTime.now().add(const Duration(days: 3650)));
                if (d != null) setState(()=>_start=d);
              }, child: const Text('Pick')),
            ]),
            Row(children: [
              Expanded(child: Text(_end==null?'End date':_end!.toLocal().toString().split(' ')[0])),
              TextButton(onPressed: () async {
                final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 365)), lastDate: DateTime.now().add(const Duration(days: 3650)));
                if (d != null) setState(()=>_end=d);
              }, child: const Text('Pick')),
            ]),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: ['Vacation','Business','Hiking','Beach'].map((a) {
              final sel = _activities.contains(a);
              return FilterChip(label: Text(a), selected: sel, onSelected: (v)=> setState(()=> v ? _activities.add(a) : _activities.remove(a)));
            }).toList()),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _save, child: const Text('Create Trip')),
          ]),
        ),
      ),
    );
  }

  void _save() {
    if (!_form.currentState!.validate()) return;
    if (_start==null || _end==null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pick dates'))); return; }
    final id = const Uuid().v4();
    final trip = Trip(id: id, title: _title.text.trim(), destination: _dest.text.trim(), startDate: _start!, endDate: _end!, activities: _activities);
    // TODO: save to Firestore later. For now just show message.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Trip created (local demo)')));
    Navigator.of(context).pop();
  }
}

