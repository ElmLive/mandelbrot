module ZoomingMandelbrot exposing (Model, init, Msg, update, view)

import Mandelbrot
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    Mandelbrot.Model


init : Int -> Model
init size =
    Mandelbrot.init size
        |> Mandelbrot.computeAll


type Msg
    = ZoomToward ( Int, Int )


update : Msg -> Model -> Model
update msg model =
    case Debug.log "msg" msg of
        ZoomToward ( x, y ) ->
            model
                |> Mandelbrot.zoomViewport y x
                |> Mandelbrot.computeAll


view : Model -> Html Msg
view model =
    div []
        [ Mandelbrot.view ZoomToward model
          -- , div
          --     [ onClick (ZoomToward ( 30, 30 ))
          --     , style
          --         [ ( "width", "2px" )
          --         , ( "height", "2px" )
          --         , ( "border", "1px solid black" )
          --         ]
          --     ]
          --     []
        ]
