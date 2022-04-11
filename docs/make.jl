using Documenter
using DatesWithNanoseconds

makedocs(
    modules = [DatesWithNanoseconds],
    sitename = "DatesWithNanoseconds.jl",
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
    repo="github.com/JeffreySarnoff/DatesWithNanoseconds.jl.git",
    devbranch = "main",
)
