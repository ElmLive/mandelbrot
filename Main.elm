module Main exposing (..)

import Mandelbrot


main =
    Mandelbrot.init 100
        |> Mandelbrot.view
