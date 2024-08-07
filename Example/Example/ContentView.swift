//
//  ContentView.swift
//  Example
//
//  Created by winddpan on 2023/8/21.
//

import HUD
import SwiftUI

struct ContentView: View {
    @State var hudState: HUDState?

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Button("message") {
                    hudState = .message("this is title text", caption: "this is caption text")
                }

                Button("success with text") {
                    hudState = .success("this is title text", caption: "this is caption text")
                }

                Button("error with text") {
                    hudState = .error("error message")
                }

                Button("loading with text") {
                    hudState = .loading("loading message")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        hudState = nil
                    }
                }

                Button("success without text") {
                    hudState = .success()
                }

                Button("error without text") {
                    hudState = .error()
                }

                Button("loading without text") {
                    hudState = .loading()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        hudState = nil
                    }
                }

                if #available(iOS 16, *) {
                    Button("loading task") {
                        $hudState.loadingTask {
                            try await Task.sleep(for: .seconds(3))
                            throw NSError(domain: "some thing wrong", code: 0)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .overlayHUD($hudState)
    }
}

#Preview {
    ContentView()
}
