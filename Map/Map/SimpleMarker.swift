import Foundation
import CoreLocation

struct MapMarkerItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}
