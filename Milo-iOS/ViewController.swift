import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Garder le full screen
        view.backgroundColor = UIColor.black
        webView.backgroundColor = UIColor.black
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        // User Agent personnalisé pour identifier l'app
        webView.customUserAgent = "oakOS-iOS-App/1.0"
        
        let url = URL(string: "http://oakos.local")!
        webView.load(URLRequest(url: url))
    }
    
    // Ajouter une classe CSS au body après chargement
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let script = "document.body.classList.add('ios-app');"
        webView.evaluateJavaScript(script, completionHandler: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
