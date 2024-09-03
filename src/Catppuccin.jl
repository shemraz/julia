#=
Catppuccin.jl

A Julia port of the Catppuccin color palette.

The palette data is sourced from the official Catppuccin *palette* repository:
https://github.com/catppuccin/palette

Palette version: v1.2.0
Commit hash: 3511b6aa48f213c255480ab69003e330da32da41
Last updated: 2024-09-03

To update the palette:
1. Download the latest palette.json from the Catppuccin repository
2. Replace the file in data/palette.json
3. Update this comment with the new version, commit hash, and date
=#

module Catppuccin

    import HTTP, JSON
    using Colors

    function get_json(url::String)
    # Fetch JSON data from a given URL
        r = HTTP.request("GET", url)
        if r.status != 200
            error("Failed to fetch palette: HTTP $(r.status)")
        end
        js = String(r.body)
        return JSON.parse(js)
    end

    function transform_to_named_tuple(flavors::Dict{K, V}) where {K, V}
    # Convert JSON data to a nested NamedTuple structure
        nt(d::Dict) = begin
            if Set(keys(d)) == Set(["r", "g", "b"])
                return parse(Colorant, "rgb($(d["r"]), $(d["g"]), $(d["b"]))")
            else
                return NamedTuple(Symbol(k) => nt(v) for (k, v) in d)
            end
        end
        nt(v::Vector) = [nt(x) for x in v]
        nt(v) = v
        return nt(flavors)
    end

    function flavors()
    # Fetch and transform the Catppuccin color palette
        url = "https://raw.githubusercontent.com/catppuccin/palette/main/palette.json"
        transform_to_named_tuple(get_json(url))
    end

    export flavors
end
