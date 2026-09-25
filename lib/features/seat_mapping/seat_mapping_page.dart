import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class SeatMappingPage extends StatefulWidget {
  const SeatMappingPage({super.key, required this.movieTitle});

  final String movieTitle;

  @override
  State<SeatMappingPage> createState() => _SeatMappingPageState();
}

class _SeatMappingPageState extends State<SeatMappingPage> {
  static const _rowLabels = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
  static const _seatCount = 8;
  static const _pricePerSeat = 12;
  static const _unavailable = {2, 3, 12, 13, 38, 39};
  final Set<int> _selected = {};

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: landscape ? 48 : kToolbarHeight,
        title: Text(
          widget.movieTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: landscape
              ? Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)
              : null,
        ),
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: landscape
                  ? _landscapeLayout(context)
                  : SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 22.h),
                      child: Column(
                        children: [
                          Text(
                            'Select Seats',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Today  •  7:30 PM  •  Grand Cinema',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: const Color(0xff8F8F99)),
                          ),
                          SizedBox(height: landscape ? 12.h : 34.h),
                          _screenIllustration(),
                          SizedBox(height: landscape ? 16.h : 32.h),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 440),
                            child: Column(
                              children: List.generate(_rowLabels.length, (row) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                        child: Text(
                                          _rowLabels[row],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(_seatCount, (
                                            column,
                                          ) {
                                            final index =
                                                row * _seatCount + column;
                                            return _seat(index);
                                          }),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      SizedBox(
                                        width: 20.w,
                                        child: Text(
                                          _rowLabels[row],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 22.w,
                            runSpacing: 10.h,
                            children: const [
                              _Legend(
                                color: Color(0xffD6D6DC),
                                label: 'Available',
                              ),
                              _Legend(
                                color: Color(0xff61C3F2),
                                label: 'Selected',
                              ),
                              _Legend(
                                color: Color(0xff2E2739),
                                label: 'Unavailable',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
            _selectionSummary(context, compact: landscape),
          ],
        ),
      ),
    );
  }

  Widget _landscapeLayout(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    child: Row(
      children: [
        SizedBox(
          width: 155,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Seats',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 5),
              Text(
                'Today  •  7:30 PM',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(fontSize: 11, color: const Color(0xff8F8F99)),
              ),
              const SizedBox(height: 3),
              Text(
                'Grand Cinema',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(fontSize: 11, color: const Color(0xff8F8F99)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final shortLayout = constraints.maxHeight < 250;
              final rowHeight = shortLayout ? 14.0 : 17.0;
              final rowGap = shortLayout ? 2.0 : 4.0;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _screenIllustration(compact: true),
                    SizedBox(height: shortLayout ? 5 : 8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 540),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(_rowLabels.length, (row) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: rowGap),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                  child: Text(
                                    _rowLabels[row],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: shortLayout ? 9 : 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      _seatCount,
                                      (column) => _seat(
                                        row * _seatCount + column,
                                        compact: true,
                                        compactHeight: rowHeight,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 18,
                                  child: Text(
                                    _rowLabels[row],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: shortLayout ? 9 : 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: shortLayout ? 5 : 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: shortLayout ? 8 : 14,
                      children: [
                        const _Legend(
                          color: Color(0xffD6D6DC),
                          label: 'Available',
                        ),
                        const _Legend(
                          color: Color(0xff61C3F2),
                          label: 'Selected',
                        ),
                        const _Legend(
                          color: Color(0xff2E2739),
                          label: 'Unavailable',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  Widget _screenIllustration({bool compact = false}) => Column(
    children: [
      Container(
        height: compact ? 3 : 5.h,
        decoration: BoxDecoration(
          color: const Color(0xff61C3F2),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff61C3F2).withValues(alpha: .25),
              blurRadius: 12,
            ),
          ],
        ),
      ),
      SizedBox(height: compact ? 4 : 8.h),
      Text(
        'SCREEN',
        style: TextStyle(
          fontSize: compact ? 9 : 10.sp,
          letterSpacing: 3,
          color: const Color(0xff92949D),
        ),
      ),
    ],
  );

  Widget _seat(int index, {bool compact = false, double compactHeight = 17}) {
    final unavailable = _unavailable.contains(index);
    final selected = _selected.contains(index);
    final color = unavailable
        ? const Color(0xff2E2739)
        : selected
        ? const Color(0xff61C3F2)
        : const Color(0xffD6D6DC);
    final seatWidth = (MediaQuery.sizeOf(context).width / 18)
        .clamp(20.0, 30.0)
        .toDouble();
    return Semantics(
      button: !unavailable,
      label:
          'Seat ${_rowLabels[index ~/ _seatCount]}${index % _seatCount + 1}${unavailable
              ? ', unavailable'
              : selected
              ? ', selected'
              : ', available'}',
      child: GestureDetector(
        onTap: unavailable
            ? null
            : () => setState(() {
                if (!_selected.add(index)) _selected.remove(index);
              }),
        child: Container(
          width: compact ? 23 : seatWidth,
          height: compact ? compactHeight : 24.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(7.r),
              bottom: Radius.circular(3.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectionSummary(
    BuildContext context, {
    bool compact = false,
  }) => Container(
    padding: compact
        ? const EdgeInsets.fromLTRB(20, 7, 20, 7)
        : EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 16.h),
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 12,
          offset: Offset(0, -3),
        ),
      ],
    ),
    child: SafeArea(
      top: false,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selected.isEmpty
                      ? 'No seats selected'
                      : '${_selected.length} seat${_selected.length == 1 ? '' : 's'} selected',
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontSize: compact ? 12 : null),
                ),
                SizedBox(height: 3.h),
                Text(
                  '\$${_selected.length * _pricePerSeat}.00 total',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(fontSize: compact ? 10 : null),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: _selected.isEmpty
                ? null
                : () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Seat selection is ready. Booking is not connected in this demo.',
                      ),
                    ),
                  ),
            style: compact
                ? ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(Size(82, 32)),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    textStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.labelLarge
                          ?.copyWith(fontSize: 12),
                    ),
                  )
                : null,
            child: const Text('Continue'),
          ),
        ],
      ),
    ),
  );
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.orientationOf(context) == Orientation.landscape;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 10 : 13.w,
          height: compact ? 10 : 13.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: compact ? 4 : 7.w),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(fontSize: compact ? 9 : null),
        ),
      ],
    );
  }
}
