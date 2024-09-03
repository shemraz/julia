using Test
using Colors

include("../src/Catppuccin.jl")

@testset "Catppuccin" begin
    @testset "get_json" begin
        # Test with a known JSON endpoint
        test_url = "https://jsonplaceholder.typicode.com/todos/1"
        result = Catppuccin.get_json(test_url)
        @test isa(result, Dict)
        @test haskey(result, "userId")
        @test haskey(result, "id")
        @test haskey(result, "title")
        @test haskey(result, "completed")
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
        @test isa(Catppuccin.flavors, NamedTuple)
        @test haskey(Catppuccin.flavors, :latte)
        @test haskey(Catppuccin.flavors, :frappe)
        @test haskey(Catppuccin.flavors, :macchiato)
        @test haskey(Catppuccin.flavors, :mocha)
        
        # Test a specific color from the palette
        @test isa(Catppuccin.flavors.latte.colors.rosewater.rgb, RGB)
    end
end
