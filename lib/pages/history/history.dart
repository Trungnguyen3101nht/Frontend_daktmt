import 'package:flutter/material.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  // Hàm để chọn ngày
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != (isStart ? _startDate : _endDate)) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  // Hàm tìm kiếm (giả định)
  void _search() {
    if (_startDate != null && _endDate != null) {
      // Thực hiện tìm kiếm với khoảng thời gian được chọn
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${_startDate.toString()} >>-->> ${_endDate.toString()}'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time period!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar_left(),
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(_startDate == null
                            ? 'Start'
                            : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectDate(context, false),
                        child: Text(_endDate == null
                            ? 'End'
                            : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _search,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 20, // Giả định có 20 lịch sử, bạn có thể thay bằng dữ liệu thực tế
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text('#${index + 1}'),
                  subtitle: Text('${DateTime.now().subtract(Duration(days: index))}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
