import CoreMedia

let time = CMTime(value: 5, timescale: 1)

var timeRange = CMTimeRange(start: .zero, duration: time)
timeRange.containsTime(time)
timeRange.containsTime(timeRange.duration)
timeRange.containsTime(timeRange.end)

timeRange = .init(start: .zero, end: time)
timeRange.containsTime(time)
timeRange.containsTime(timeRange.duration)
timeRange.containsTime(timeRange.end)
