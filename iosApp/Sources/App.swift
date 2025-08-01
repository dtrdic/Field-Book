import SwiftUI
import sharedKit

@main
struct IosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        ComposeView()
            .ignoresSafeArea()
    }
}

struct ComposeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
       do {
           let controller = MainKt.MainViewController()
           return controller
       } catch {
           print("Error creating Compose view controller: \(error)")
           // Return a fallback view controller
           let fallbackController = UIViewController()
           fallbackController.view.backgroundColor = .systemBackground

           let label = UILabel()
           label.text = "Error loading KMP module: \(error.localizedDescription)"
           label.textAlignment = .center
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false

           fallbackController.view.addSubview(label)
           NSLayoutConstraint.activate([
               label.centerXAnchor.constraint(equalTo: fallbackController.view.centerXAnchor),
               label.centerYAnchor.constraint(equalTo: fallbackController.view.centerYAnchor),
               label.leadingAnchor.constraint(greaterThanOrEqualTo: fallbackController.view.leadingAnchor, constant: 20),
               label.trailingAnchor.constraint(lessThanOrEqualTo: fallbackController.view.trailingAnchor, constant: -20)
           ])

           return fallbackController
       }
    }
    func updateUIViewController(_: UIViewController, context: Context) {}
}
