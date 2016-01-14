module OpenSolid.Core.Transformation3d
  ( translationBy
  , rotationAbout
  , compound
  ) where


import OpenSolid.Core exposing (Transformation3d, Vector3d, Point3d)


plus: Vector3d -> Point3d -> Point3d
plus vector point =
  Point3d (point.x + vector.x) (point.y + vector.y) (point.z + vector.z)


minus: Point3d -> Point3d -> Vector3d
minus other point =
  Vector3d (point.x - other.x) (point.y - other.y) (point.z - other.z)


times: Float -> Vector3d -> Vector3d
times scale vector =
  Vector3d (scale * vector.x) (scale * vector.y) (scale * vector.z)


translationBy: Vector3d -> Transformation3d
translationBy vector =
  ( identity
  , plus vector
  )


rotateVector: (Direction3d, Direction3d, Direction3d) -> Vector3d -> Vector3d
rotateVector (xDirection, yDirection, zDirection) vector =
  plus (times vector.z zDirection) (plus (times vector.y yDirection) (times vector.x xDirection))


rotatePoint: Point3d -> (Direction3d, Direction3d, Direction3d) -> Point3d -> Point3d
rotatePoint originPoint basis point =
  let
    radialVector = minus originPoint point
    rotatedVector = rotateVector basis radialVector
  in
    plus rotatedVector originPoint


rotationBasis: Direction3d -> Float -> (Direction3d, Direction3d, Direction3d)
rotationBasis direction angle =
  let
    halfAngle = 0.5 * angle
    sinHalfAngle = sin halfAngle
    x = direction.x * sinHalfAngle
    y = direction.y * sinHalfAngle
    z = direction.z * sinHalfAngle
    w = cos halfAngle
    wx = w * x
    wy = w * y
    wz = w * z
    xx = x * x
    xy = x * y
    xz = x * z
    yy = y * y
    yz = y * z
    zz = z * z
    xDirection = Direction3d (1 - 2 * (yy + zz)) (2 * (xy + wz)) (2 * (xz - wy))
    yDirection = Direction3d (2 * (xy - wz)) (1 - 2 * (xx + zz)) (2 * (yz + wx))
    zDirection = Direction3d (2 * (xz + wy)) (2 * (yz - wx)) (1 - 2 * (xx + yy))
  in
    (xDirection, yDirection, zDirection)


rotationAbout: Axis3d -> Float -> Transformation3d
rotationAbout axis angle =
  let
    basis = rotationBasis axis.direction angle
  in
    ( rotateVector basis
    , rotatePoint axis.originPoint basis
    )


compound: Transformation3d -> Transformation3d -> Transformation3d
compound outer inner =
  ( fst outer << fst inner
  , snd outer << snd inner
  )
