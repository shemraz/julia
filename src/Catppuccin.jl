module Catppuccin

    import HTTP, JSON
    using Colors

    function get_json(url::String)
        r = HTTP.request("GET", url)
        js = String(r.body)
        return JSON.parse(js)
    end

    function transform_to_named_tuple(flavors::Dict{K, V}) where {K, V}
        nt(d::Dict) = Set(keys(d)) == Set(["r", "g", "b"]) ? parse(Colorant, "rgb($(d["r"]), $(d["g"]), $(d["b"]))") : NamedTuple(Symbol(k) => nt(v) for (k, v) in d)
        nt(v::Vector) = [nt(x) for x in v]
        nt(v) = v
        return nt(flavors)
    end

    const flavors = transform_to_named_tuple(get_json("https://raw.githubusercontent.com/catppuccin/palette/main/palette.json")) 

    export flavors
end
