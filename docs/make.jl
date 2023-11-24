using VirialUEG
using Documenter

DocMeta.setdocmeta!(VirialUEG, :DocTestSetup, :(using VirialUEG); recursive=true)

makedocs(;
    modules=[VirialUEG],
    authors="Biplab Mahato",
    repo="https://github.com/biplab37/VirialUEG.jl/blob/{commit}{path}#{line}",
    sitename="VirialUEG.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://biplab37.github.io/VirialUEG.jl",
        edit_link="main",
        assets=String[]
    ),
    pages=[
        "Home" => "index.md",
        "Examples" => "examples.md",
        "Indices" => "indices.md"
    ]
)

# deploydocs(;
#     repo="github.com/biplab37/VirialUEG.jl",
#     devbranch="main",
# )
