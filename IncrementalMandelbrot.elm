module IncrementalMandelbrot exposing (Model, init, Msg, update, view)

import Mandelbrot
import Task
import Html exposing (..)
import Process


type alias Model =
    { fractal : Mandelbrot.Model
    , nextRow : Int
    }


init : Int -> ( Model, Cmd Msg )
init size =
    ( { fractal = Mandelbrot.init size
      , nextRow = 0
      }
    , calcNextRowCmd
    )


calcNextRowCmd : Cmd Msg
calcNextRowCmd =
    Process.sleep 0
        |> Task.perform
            (always CalulcateNextRow)
            (always CalulcateNextRow)



-- UPDATE


type Msg
    = CalulcateNextRow


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CalulcateNextRow ->
            if model.nextRow < 100 then
                ( { model
                    | fractal = Mandelbrot.computeRow model.nextRow model.fractal
                    , nextRow = model.nextRow + 1
                  }
                , calcNextRowCmd
                )
            else
                ( model, Cmd.none )



-- VIEW


view : Model -> Html msg
view model =
    Mandelbrot.view model.fractal
