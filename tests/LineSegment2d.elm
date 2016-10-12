{- This Source Code Form is subject to the terms of the Mozilla Public License,
   v. 2.0. If a copy of the MPL was not distributed with this file, you can
   obtain one at http://mozilla.org/MPL/2.0/.

   Copyright 2016 by Ian Mackenzie
   ian.e.mackenzie@gmail.com
-}


module LineSegment2d exposing (suite)

import Test exposing (Test)
import Test.Runner.Html as Html
import OpenSolid.LineSegment2d as LineSegment2d
import OpenSolid.Core.Encode as Encode
import OpenSolid.Core.Decode as Decode
import OpenSolid.Core.Fuzz as Fuzz
import OpenSolid.Core.Expect as Expect
import Generic


jsonRoundTrips : Test
jsonRoundTrips =
    Generic.jsonRoundTrips Fuzz.lineSegment2d
        Encode.lineSegment2d
        Decode.lineSegment2d


suite : Test
suite =
    Test.describe "OpenSolid.Core.LineSegment2d"
        [ jsonRoundTrips
        ]


main : Program Never
main =
    Html.run suite