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
