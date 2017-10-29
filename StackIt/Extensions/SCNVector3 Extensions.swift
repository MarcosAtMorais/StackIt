import SceneKit

extension SCNVector3 {
  func absoluteValue() -> SCNVector3 {
    return SCNVector3Make(abs(self.x), abs(self.y), abs(self.z))
  }
}

func + (first: SCNVector3, second: SCNVector3) -> SCNVector3 {
  return SCNVector3Make(first.x + second.x, first.y + second.y, first.z + second.z)
}

func - (first: SCNVector3, second: SCNVector3) -> SCNVector3 {
  return SCNVector3Make(first.x - second.x, first.y - second.y, first.z - second.z)
}
