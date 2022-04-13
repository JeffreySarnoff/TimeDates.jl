# TimeDates.jl

Offers TimeDate, a date-and-time type with nanosecond resolution

* plays well with others

    * TimeDate works like DateTime with more precision
    * Supports Dates.jl methods
    * Interconverts with DateTime, Date

* introduces enhancements

    * Adds ranges with CompoundPeriod steps
    * Adds `periods`, a NamedTuple constructor
    * introduces round(::Time, ::TimePeriod, ::RoundingMode)

----

- installs with  `using Pkg; Pkg.add("TimeDates")`

- ask questions
  - on [Discourse](https://discourse.julialang.org/latest)
  - on [Slack](https://app.slack.com/client/T68168MUP)
  - on [Zulip](https://julialang.zulipchat.com/#narrow/stream/321834-dates-times-zones) -- using the stream `dates-times-zones`
  
- report any issues [here](https://github.com/JeffreySarnoff/TimeDates.jl/issues)

----

**click on the triple bar at the upper right for the docs menu**
