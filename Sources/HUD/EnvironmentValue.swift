import Foundation
import SwiftUI

public protocol HUDRender {
    associatedtype Content: View
    func render(_ state: HUDState) -> Content
}

public struct HUDRenderKey: EnvironmentKey {
    public static var defaultValue: any HUDRender {
        HUDDefaultRender()
    }
}

public extension EnvironmentValues {
    var hudRender: any HUDRender {
        get { return self[HUDRenderKey.self] }
        set { self[HUDRenderKey.self] = newValue }
    }
}
