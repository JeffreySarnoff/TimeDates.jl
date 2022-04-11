"""

nanoseconds since UNIX epoch
datetime2epoch(x::DateTime) = (Dates.value(x) - Dates.UNIXEPOCH)*1_000_000


function approx_nanoseconds_from_midnight()
    nw = now()
    millis_now = Dates.value(nw)
    millis_midnight = Dates.value(round(nw, Day, RoundDown))
    millis_from_midnight = millis_now - millis_midnight
    millis_from_midnight * 1_000_000
end

function tosub_from_time_ns()
    nw = now()
    ns = time_ns()

    millis_now = Dates.value(nw)
    millis_midnight = Dates.value(round(nw, Day, RoundDown))
    millis_from_midnight = millis_now - millis_midnight
    ns - millis_from_midnight * 1_000_000
end

function approx_datenstime()
    tosub = tosub_from_time_ns()
    today(), Time(Nanosecond(time_ns() - tosub))
end

julia> x=now(); y = round(x,Day,RoundDown); nanosfrommidnight=(value(x)-value(y))*Int128(1_000_000)
13098511000000

julia> time_ns()
0x0002abe6b3f73300

julia> Int128(time_ns())
751973719845100

julia> Int128(time_ns()) - nanosfrommidnight
738908752968000

julia> subfromtimens=Int128(time_ns()) - nanosfrommidnight
738929257053700

julia> time_ns()-subfromtimens
13109990896000

julia> nss=time_ns()-subfromtimens
13153238539900

julia> Time(Nanosecond(nss))
03:39:13.2385399

julia> Time(Nanosecond(time_ns()-subfromtimens))
03:40:00.2146499



using TimesDates, Dates
val = 1543190400010159332
sec = val ÷ 10^9
ms = val ÷ 10^6 - sec * 10^3
ns = val % 10^6
origin = TimeDate(unix2datetime(sec))
ms = Millisecond(ms)
ns = Nanosecond(ns)
result = origin + ms + ns
This gives 2018-11-26T00:00:00.010159332.

julia> ms1 = 135; ms1ns = ms1 * 1_000_000; ns1 = 748841280053500;

julia> ms2 = 664; ms1ns = ms2 * 1_000_000; ns2 = 748841808393900;

julia> delta_ms = ms2 - ms1; delta_ns = ns2 - ns1
528340400

julia> delta_ms = ms2 - ms1; delta_msns = delta_ms * 1_000_000; delta_ns = ns2 - ns1;

julia> delta_msns, delta_ns
(529000000, 528340400)

julia> ans[1] - ans[2]
659600


julia> timestate1 = (DateTime("2022-04-09T02:46:49.135"), (748841280053500, (0.13499999046325684, 1649486809), 748841280053500), DateTime("2022-04-09T02:46:49.135"))
(DateTime("2022-04-09T02:46:49.135"), (748841280053500, (0.13499999046325684, 1649486809), 748841280053500), DateTime("2022-04-09T02:46:49.135"))

julia> timestate2 = (DateTime("2022-04-09T02:46:49.664"), (748841808393900, (0.6640000343322754, 1649486809), 748841808393900), DateTime("2022-04-09T02:46:49.664"))
(DateTime("2022-04-09T02:46:49.664"), (748841808393900, (0.6640000343322754, 1649486809), 748841808393900), DateTime("2022-04-09T02:46:49.664"))


julia>  @inline function times()
          (time_ns(), time(), time_ns())
       end

julia> timestate() =  now(), reform(times()), now();

julia> reform(ans) = Int128(ans[1]), imodf(ans[2]), Int128(ans[3])
reform (generic function with 1 method)

julia> imodf(x) = let mf = modf(x)
          mf[1], Int64(mf[2])
       end
imodf (generic function with 1 method)
"""









