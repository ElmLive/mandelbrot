module Main exposing (..)

import Mandelbrot


main =
    Mandelbrot.init 400
        |> Mandelbrot.computeAll
        |> Mandelbrot.view
