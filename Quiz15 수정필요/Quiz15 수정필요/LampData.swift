import SwiftUI

class LampData: ObservableObject {
    @Published var sharedData: String = ""
    @Published var isLampOn: Bool = true
    @Published var isLampRed: Bool = false
    
    var lampImageName: String {
        if !isLampOn {
            return "lamp_off"
        } else {
            return isLampRed ? "lamp_red" : "lamp_on"
        }
    }
}
