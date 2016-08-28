module Main exposing (..)

import Mandelbrot


main =
    Mandelbrot.init 200
        |> Mandelbrot.computeAll
        |> Mandelbrot.view
