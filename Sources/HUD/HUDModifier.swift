import Foundation
import SwiftUI

struct HUDModifier: ViewModifier {
    @Binding var hudState: HUDState?

    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if hudState?.preventTouch == true {
                        Color.gray.opacity(0.001)
                            .allowsHitTesting(true)
                    }
                    HUDView(hudState: $hudState)
                }
            )
    }
}

struct HUDView: View {
    @Binding var hudState: HUDState?
    @Environment(\.hudRender) private var hudRender
    @State private var delayTask: DispatchWorkItem?
    @State private var visible = true
    @State private var playingHudState: HUDState?

    var body: some View {
        hudView
            .onChange(of: hudState) { newValue in
                if let newValue {
                    update(newValue)
                } else {
                    dismiss()
                }
            }
    }

    @ViewBuilder
    private var hudView: some View {
        Group {
            if visible, let playingHudState {
                AnyView(hudRender.render(playingHudState))
            }
        }
        .animation(.easeInOut, value: visible)
    }

    private func dismiss() {
        hudState = nil
        delayTask?.cancel()

        withAnimation {
            playingHudState = nil
            visible = false
        }
    }

    private func update(_ hudState: HUDState) {
        guard hudState != playingHudState else {
            return
        }

        delayTask?.cancel()
        visible = true
        playingHudState = hudState

        if hudState.shouldAutoHide, hudState.autoHideInterval > 0 {
            delayTask = DispatchWorkItem(block: {
                self.dismiss()
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + hudState.autoHideInterval, execute: delayTask!)
        }
    }
}
