module Main exposing (..)

import Mandelbrot
import IncrementalMandelbrot
import Html.App


main =
    Mandelbrot.init 400
        |> Mandelbrot.computeAll
        |> Mandelbrot.view



-- main =
--     Html.App.program
--         { init = IncrementalMandelbrot.init 400
--         , subscriptions = \_ -> Sub.none
--         , update = IncrementalMandelbrot.update
--         , view = IncrementalMandelbrot.view
--         }
