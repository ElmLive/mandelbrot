module Main exposing (..)

import Mandelbrot


main =
    Mandelbrot.init 100
        |> Mandelbrot.computeCell ( 5, 5 )
        |> Mandelbrot.computeCell ( 99, 99 )
        |> Mandelbrot.view
