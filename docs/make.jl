using Documenter
using TimeDates

makedocs(
    modules = [TimeDates],
    sitename = "TimeDates.jl",
    authors = "Jeffrey Sarnoff",
    clean = false,
    strict = !("strict=false" in ARGS),
    doctest = ("doctest=only" in ARGS) ? :only : true,
    format = Documenter.HTML(
        # Use clean URLs, unless built as a "local" build
        prettyurls = !("local" in ARGS),
        highlights = ["yaml"],
        ansicolor = true,
    ),
    pages = [
        "Home" => "index.md",
        "Quick Start" => Any[
            "Construction" => "quickstart/construction.md",
            "Conversion" => "quickstart/convert.md",
            "Accessing" => "quickstart/accessor.md"
        ],
        "Guide" => Any[
            "Arithmetic" => "userguide/arithmetic.md",
            "Rounding" => "userguide/rounding.md",
        ],
        "Enhancements" => Any[
            "Compound Ranges" => "enhance/ranges.md",
            "Using NamedTuples" => "enhance/namedtuples.md",
        ],
    ],
)

#=
Deploy docs to Github pages.
=#
Documenter.deploydocs(
    repo="github.com/JeffreySarnoff/TimeDates.jl.git",
    devbranch = "main",
)
