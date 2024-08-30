import Foundation
import SwiftUI

open class HUDDefaultRender: HUDRender {
    @ViewBuilder
    open func render(_ state: HUDState) -> some View {
        HUDDefaultView(state: state)
    }
}

struct HUDDefaultView: View {
    @Environment(\.colorScheme) private var colorScheme
    let state: HUDState

    var body: some View {
        VStack(spacing: 4) {
            indicatorView(state.identifier)
                .frame(minWidth: 60)
                .padding(10)

            if let title = state.title, !title.isEmpty {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18, weight: .medium))
            }
            if let caption = state.caption, !caption.isEmpty {
                Text(caption)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
            }
        }
        .padding(20)
        .background(
            Color.clear
                .background(Material.thin)
                .background(colorScheme == .light ? Color.gray.opacity(0.1) : Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        )
    }

    @ViewBuilder
    func indicatorView(_ identifier: HUDIdentifier) -> some View {
        switch identifier {
        case .success:
            Image(systemName: "checkmark")
                .font(.system(size: 32, weight: .medium))
        case .error:
            Image(systemName: "xmark")
                .font(.system(size: 32, weight: .medium))
        case .loading:
            if #available(iOS 15.0, *) {
                ProgressView()
                    .controlSize(.large)
            } else {
                ProgressView()
                    .scaleEffect(1.5)
            }
        case .message:
            EmptyView()
        }
    }
}
