using Test
using Colors

include("../src/Catppuccin.jl")

@testset "Catppuccin" begin
    @testset "read_json" begin
        # Test with default path to `palette.json`
        result = Catppuccin.read_json(Catppuccin.DEFAULT_PALETTE_PATH)
        @test isa(result, Dict)
        @test haskey(result, "latte")
        @test haskey(result, "frappe")
        @test haskey(result, "macchiato")
        @test haskey(result, "mocha")
    end

    @testset "transform_to_named_tuple" begin
        # Test with a simple RGB color
        simple_color = Dict("color" => Dict("r" => 255, "g" => 0, "b" => 0))
        result = Catppuccin.transform_to_named_tuple(simple_color)
        @test isa(result.color, RGB)
        @test result.color == RGB(1.0, 0.0, 0.0)

        # Test with a nested structure
        nested_data = Dict(
            "flavor1" => Dict(
                "color1" => Dict("r" => 255, "g" => 0, "b" => 0),
                "color2" => Dict("r" => 0, "g" => 255, "b" => 0)
            ),
            "flavor2" => Dict(
                "color1" => Dict("r" => 0, "g" => 0, "b" => 255)
            )
        )
        result = Catppuccin.transform_to_named_tuple(nested_data)
        @test isa(result, NamedTuple)
        @test isa(result.flavor1, NamedTuple)
        @test isa(result.flavor1.color1, RGB)
        @test result.flavor1.color1 == RGB(1.0, 0.0, 0.0)
        @test result.flavor1.color2 == RGB(0.0, 1.0, 0.0)
        @test result.flavor2.color1 == RGB(0.0, 0.0, 1.0)
    end

    @testset "flavors constant" begin
        result = Catppuccin.flavors()
        @test isa(result, NamedTuple)
        @test haskey(result, :latte)
        @test haskey(result, :frappe)
        @test haskey(result, :macchiato)
        @test haskey(result, :mocha)
        
        # Test a specific color from the palette
        @test isa(result.latte.colors.rosewater.rgb, RGB)
    end
end
