module Main exposing (..)

import Mandelbrot
import IncrementalMandelbrot
import ZoomingMandelbrot
import Html.App


-- main =
--     Mandelbrot.init 250
--         |> Mandelbrot.computeAll
--         |> Mandelbrot.view
--


main =
    Html.App.beginnerProgram
        { model = ZoomingMandelbrot.init 200
        , update = ZoomingMandelbrot.update
        , view = ZoomingMandelbrot.view
        }



-- main =
--     Html.App.program
--         { init = IncrementalMandelbrot.init 400
--         , subscriptions = \_ -> Sub.none
--         , update = IncrementalMandelbrot.update
--         , view = IncrementalMandelbrot.view
--         }
