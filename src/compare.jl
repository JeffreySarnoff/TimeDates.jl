Base.isequal(td1::TimeDate, td2::TimeDate) =
    (td1.date == td2.date) && (td1.time == td2.time)
Base.isequal(td::TimeDate, d::Date) = isequal(td.date, d) && iszero(td.time)
Base.isequal(td::TimeDate, dt::DateTime) = isequal(td.date, Date(dt)) && isequal(td.time, Time(dt))
Base.isequal(d::Date, td::TimeDate) = isequal(td, d)
Base.isequal(dt::DateTime, td::TimeDate) = isequal(td, dt)

Base.isless(td1::TimeDate, td2::TimeDate) =
    (td1.date < td2.date) || ((td1.date == td2.date) && (td1.time < td2.time))
Base.isless(td::TimeDate, d::Date) = isless(promote(td, d)...)
Base.isless(td::TimeDate, dt::DateTime) = isless(promote(td, dt)...)
Base.isless(d::Date, td::TimeDate) = isless(promote(d, td)...)
Base.isless(dt::DateTime, td::TimeDate) = isless(promote(dt, td)...)

Base.:(==)(td1::TimeDate, td2::TimeDate) =
    (td1.date == td2.date) && (td1.time == td2.time)
Base.:(<)(td1::TimeDate, td2::TimeDate) =
    (td1.date < td2.date) || ((td1.date == td2.date) && (td1.time < td2.time))
Base.:(<=)(td1::TimeDate, td2::TimeDate) =
    (td1.date < td2.date) || ((td1.date == td2.date) && (td1.time <= td2.time))

Base.:(==)(td::TimeDate, d::Date) = isequal(td, d)
Base.:(==)(d::Date, td::TimeDate) = isequal(d, td)
Base.:(<)(td::TimeDate, d::Date) = isless(td, d)
Base.:(<)(d::Date, td::TimeDate) = isless(d, td)
Base.:(<=)(td::TimeDate, d::Date) = (<=)(td, TimeDate(d))
Base.:(<=)(d::Date, td::TimeDate) = (<=)(TimeDate(d), td)
