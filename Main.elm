module Main exposing (..)

import Mandelbrot


main =
    Mandelbrot.init 100
        |> Mandelbrot.computeRow 5
        |> Mandelbrot.computeRow 6
        |> Mandelbrot.computeRow 10
        |> Mandelbrot.computeRow 20
        |> Mandelbrot.view
