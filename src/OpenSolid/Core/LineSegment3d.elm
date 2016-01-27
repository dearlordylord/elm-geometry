module OpenSolid.Core.LineSegment3d
  ( endpoints
  , mapReduce
  , vector
  , direction
  , normalDirection
  , squaredLength
  , length
  , scaledAbout
  , transformedBy
  , projectedOntoAxis
  , projectedOntoPlane
  , projectedIntoPlane
  ) where


import OpenSolid.Core exposing (..)
import OpenSolid.Core.Vector3d as Vector3d
import OpenSolid.Core.Point3d as Point3d


endpoints: LineSegment3d -> (Point3d, Point3d)
endpoints (LineSegment3d firstEndpoint secondEndpoint) =
  (firstEndpoint, secondEndpoint)


mapReduce: (Point3d -> a) -> (a -> a -> b) -> LineSegment3d -> b
mapReduce map reduce (LineSegment3d firstEndpoint secondEndpoint) =
  reduce (map firstEndpoint) (map secondEndpoint)


vector: LineSegment3d -> Vector3d
vector (LineSegment3d firstEndpoint secondEndpoint) =
  Point3d.minus firstEndpoint secondEndpoint


direction: LineSegment3d -> Direction3d
direction =
  vector >> Vector3d.direction


normalDirection: LineSegment3d -> Direction3d
normalDirection =
  vector >> Vector3d.normalDirection


squaredLength: LineSegment3d -> Float
squaredLength =
  vector >> Vector3d.squaredLength


length: LineSegment3d -> Float
length =
  vector >> Vector3d.length


scaledAbout: Point3d -> Float -> LineSegment3d -> LineSegment3d
scaledAbout point scale =
  mapReduce (Point3d.scaledAbout point scale) LineSegment3d


transformedBy: Transformation3d -> LineSegment3d -> LineSegment3d
transformedBy transformation =
  mapReduce (Point3d.transformedBy transformation) LineSegment3d


projectedOntoAxis: Axis3d -> LineSegment3d -> LineSegment3d
projectedOntoAxis axis =
  mapReduce (Point3d.projectedOntoAxis axis) LineSegment3d


projectedOntoPlane: Plane3d -> LineSegment3d -> LineSegment3d
projectedOntoPlane plane =
  mapReduce (Point3d.projectedOntoPlane plane) LineSegment3d


projectedIntoPlane: Plane3d -> LineSegment3d -> LineSegment2d
projectedIntoPlane plane =
  mapReduce (Point3d.projectedIntoPlane plane) LineSegment2d
