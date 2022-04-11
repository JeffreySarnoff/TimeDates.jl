const HoursPerDay = Int64(24)
const MinutesPerHour = Int64(60)
const SecondsPerMinute = Int64(60)
const MillisecondsPerSecond = Int64(1_000)
const MicrosecondsPerMillisecond = Int64(1_000)
const NanosecondsPerMicrosecond = Int64(1_000)

const MinutesPerDay = HoursPerDay * MinutesPerHour

const SecondsPerHour = MinutesPerHour * SecondsPerMinute
const SecondsPerDay = HoursPerDay * SecondsPerHour

const MillisecondsPerMinute = SecondsPerMinute * MillisecondsPerSecond
const MillisecondsPerHour = MinutesPerHour * MillisecondsPerMinute
const MillisecondsPerDay = HoursPerDay * MillisecondsPerHour

const MicrosecondsPerSecond = MillisecondsPerSecond * MicrosecondsPerMillisecond
const MicrosecondsPerMinute = SecondsPerMinute * MillisecondsPerSecond
const MicrosecondsPerHour = MinutesPerHour * MillisecondsPerMinute
const MicrosecondsPerDay = HoursPerDay * MillisecondsPerHour

const NanosecondsPerMillisecond = MicrosecondsPerMillisecond * NanosecondsPerMicrosecond
const NanosecondsPerSecond = MillisecondsPerSecond * NanosecondsPerMillisecond
const NanosecondsPerMinute = SecondsPerMinute * NanosecondsPerSecond
const NanosecondsPerHour = MinutesPerHour * NanosecondsPerMinute
const NanosecondsPerDay = HoursPerDay * NanosecondsPerHour

const Time0 = Time(0)

