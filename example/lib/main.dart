import 'package:flutter/material.dart';
import 'package:smart_progress_dialog/smart_progress_dialog.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Smart Progress Dialog Example',
      home: ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final SmartProgressController _controller = SmartProgressController();
  final List<String> _items = List.generate(20, (i) => 'Item ${i + 1}');
  bool _isLoadingMore = false;

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _items.addAll(List.generate(10, (i) => 'Item ${_items.length + i + 1}'));
      _isLoadingMore = false;
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _items.clear();
      _items.addAll(List.generate(20, (i) => 'Item ${i + 1}'));
    });
  }

  void _simulateSuccess() async {
    _controller.attach(context); // Attach the controller to the context
    _controller.showLoading("Loading..."); // Show loading state
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    _controller.showSuccess(message: "Successful"); // Show success state
  }

  void _simulateInfo() async {
    _controller.attach(context); // Attach the controller to the context
    _controller.showLoading("Loading..."); // Show loading state
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    _controller.showInfo(message: "This is an info!"); // Show success state
  }

  void _simulateWarning() async {
    _controller.attach(context); // Attach the controller to the context
    _controller.showLoading("Processing..."); // Show loading state
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    _controller.showWarning(
        message: "This is a warning!"); // Show warning state
  }

  void _simulateFailure() async {
    _controller.attach(context); // Attach the controller to the context
    _controller.showLoading("Processing..."); // Show loading state
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    _controller.showFailure(
        message: "Something went wrong."); // Show failure state
  }

  void _showSnackBar() {
    SmartSnackBar.show(context, "This is a snack bar message",
        type: SmartSnackBarType.warning,
        duration: SmartSnackBarDuration.short,
        position: SmartSnackBarPosition.top,
        backgroundColor: Colors.red,
        showIcon: false);
    SmartSnackBar.show(context, "This is a snack bar message",
        title: 'Some title',
        type: SmartSnackBarType.success,
        duration: SmartSnackBarDuration.indefinite,
        position: SmartSnackBarPosition.bottom,
        showIcon: true,
        showCloseIcon: true, onClose: () {
      SmartSnackBar.show(context, "Snack bar closed",
          type: SmartSnackBarType.info, duration: SmartSnackBarDuration.short);
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Dialog Example')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Buttons to trigger different states
                ElevatedButton(
                  onPressed: _simulateSuccess,
                  child: const Text("Show Success"),
                ),
                ElevatedButton(
                  onPressed: _simulateInfo,
                  child: const Text("Show Info"),
                ),
                ElevatedButton(
                  onPressed: _simulateWarning,
                  child: const Text("Show Warning"),
                ),
                ElevatedButton(
                  onPressed: _simulateFailure,
                  child: const Text("Show Failure"),
                ),
                ElevatedButton(
                  onPressed: _showSnackBar,
                  child: const Text("Show Snackbar"),
                ),
              ],
            ),
          ),
          Expanded(
            child: SmartRefreshIndicator(
              onRefresh: _refresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (!_isLoadingMore &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    _loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: _items.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _items.length) {
                      return SmartListLoader(isLoading: _isLoadingMore);
                    }
                    return ListTile(title: Text(_items[index]));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
