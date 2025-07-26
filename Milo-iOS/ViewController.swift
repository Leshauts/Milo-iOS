import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    override func loadView() {
        // Créer une vue parent avec fond gris clair
        let containerView = UIView()
        containerView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        self.view = containerView

        // Initialiser la WebView
        webView = WKWebView()
        webView.navigationDelegate = self

        // Fond WebView transparent pour laisser passer le fond de la vue
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.scrollView.backgroundColor = .clear

        // Début invisible
        webView.alpha = 0.0

        // Ajouter la WebView dans la vue parente
        containerView.addSubview(webView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.customUserAgent = "Milo-iOS-App/1.0"

        // Charger l'URL (après affichage pour éviter le lag)
        DispatchQueue.main.async {
            let url = URL(string: "http://milo.local")!
            self.webView.load(URLRequest(url: url))
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Ajouter une classe CSS
        let script = "document.body.classList.add('ios-app');"
        webView.evaluateJavaScript(script, completionHandler: nil)

        // Animation de fondu
        UIView.animate(withDuration: 0.3) {
            webView.alpha = 1.0
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
