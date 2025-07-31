import SwiftUI
import sharedKit

@main
struct IosApp: App {
    var body: some Scene {
        WindowGroup {
            ComposeView()
        }
    }
}

struct ComposeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        MainKt.MainViewController()
    }
    func updateUIViewController(_: UIViewController, context: Context) {}
}
