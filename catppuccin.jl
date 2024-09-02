# TODO: Catppuccin URL goes here

import HTTP, JSON

const flavors = HTTP.request("GET", "https://raw.githubusercontent.com/catppuccin/palette/main/palette.json").body |> String |> JSON.parse


const _catppuccin_latte = PlotTheme(
    Dict([
        :bg =>            colorant"",
        :bginside =>      colorant"",
        :fg =>            colorant"",
        :fgtext =>        colorant"",
        :fgguide =>       colorant"",
        :fglegend =>      colorant"",
        :palette =>       colorant"",
        :colorgradient => colorant"",
    ])
)

const _catppuccin_frappe = PlotTheme(
    Dict([
        :bg =>            colorant"",
        :bginside =>      colorant"",
        :fg =>            colorant"",
        :fgtext =>        colorant"",
        :fgguide =>       colorant"",
        :fglegend =>      colorant"",
        :palette =>       colorant"",
        :colorgradient => colorant"",
    ])
)



const _catppuccin_macchiato = PlotTheme(
    Dict([
        :bg =>            colorant"",
        :bginside =>      colorant"",
        :fg =>            colorant"",
        :fgtext =>        colorant"",
        :fgguide =>       colorant"",
        :fglegend =>      colorant"",
        :palette =>       colorant"",
        :colorgradient => colorant"",
    ])
)

const _catppuccin_mocha = PlotTheme(
    Dict([
        :bg =>            colorant"",
        :bginside =>      colorant"",
        :fg =>            colorant"",
        :fgtext =>        colorant"",
        :fgguide =>       colorant"",
        :fglegend =>      colorant"",
        :palette =>       colorant"",
        :colorgradient => colorant"",
    ])
)

