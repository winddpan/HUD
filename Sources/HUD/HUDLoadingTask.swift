import Foundation
import SwiftUI

public extension Binding where Value == HUDState? {
    @MainActor
    func loadingTask(operation: @escaping () async throws -> Void) {
        wrappedValue = .loading()
        Task {
            do {
                try await operation()
                DispatchQueue.main.async {
                    if self.wrappedValue == .loading() {
                        self.wrappedValue = nil
                    }
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    self.wrappedValue = .error(NSLocalizedString(error.localizedDescription, comment: ""))
                }
            }
        }
    }
}
