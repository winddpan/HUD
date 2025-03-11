import Foundation
import SwiftUI

public enum HUDIdentifier: Equatable {
    case success
    case error
    case loading
    case message
}

public struct HUDState: Equatable {
    public let uuid: String
    public let identifier: HUDIdentifier
    public let title: String?
    public let caption: String?
    public let preventTouch: Bool
    public let shouldAutoHide: Bool
    public let autoHideInterval: TimeInterval

    public init(
        uuid: String = UUID().uuidString,
        identifier: HUDIdentifier,
        title: String? = nil,
        caption: String? = nil,
        preventTouch: Bool,
        shouldAutoHide: Bool,
        autoHideInterval: TimeInterval
    ) {
        self.uuid = uuid
        self.identifier = identifier
        self.title = title
        self.caption = caption
        self.preventTouch = preventTouch
        self.shouldAutoHide = shouldAutoHide
        self.autoHideInterval = autoHideInterval
    }
}

extension HUDState {
    public static func loading(_ title: String? = nil, caption: String? = nil) -> Self {
        HUDState(
            uuid: "Loading\(title ?? "")",
            identifier: .loading,
            title: title,
            caption: caption,
            preventTouch: true,
            shouldAutoHide: false,
            autoHideInterval: 0)
    }

    public static func success(_ title: String? = nil, caption: String? = nil) -> Self {
        HUDState(
            identifier: .success,
            title: title,
            caption: caption,
            preventTouch: false,
            shouldAutoHide: true,
            autoHideInterval: 2.5)
    }

    public static func error(_ title: String? = nil, caption: String? = nil) -> Self {
        HUDState(
            identifier: .error,
            title: title,
            caption: caption,
            preventTouch: false,
            shouldAutoHide: true,
            autoHideInterval: 2.5)
    }

    public static func message(_ title: String, caption: String? = nil) -> Self {
        HUDState(
            identifier: .message,
            title: title,
            caption: caption,
            preventTouch: false,
            shouldAutoHide: true,
            autoHideInterval: 2.5)
    }
}

extension View {
    public func overlayHUD(_ state: Binding<HUDState?>) -> some View {
        modifier(HUDModifier(hudState: state))
    }
}
