# SwiftUI HUD
iOS14+ macOS13+

# Demo
https://github.com/user-attachments/assets/7c741aa6-c9f7-45e7-96bb-31f266ccf063

# Usage
```
struct ContentView: View {
    @State var hudState: HUDState?

    var body: some View {
        ZStack {
            Color.clear

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
```
