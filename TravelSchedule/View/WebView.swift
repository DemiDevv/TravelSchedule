//
//  WebView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 12.04.2025.
//

//
//  WebView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 12.04.2025.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var isDarkMode: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        
        let url = URL(string: "https://www.yandex.ru/legal/practicum_offer/")!
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        updateTheme(for: webView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.updateTheme(for: webView)
        }
    }
    
    private func updateTheme(for webView: WKWebView) {
        let backgroundColor = isDarkMode ? "#1A1B22" : "#FFFFFF"
        let textColor = isDarkMode ? "#FFFFFF" : "#000000"
        
        let js = """
        (function() {
            document.body.style.backgroundColor = '\(backgroundColor)';
            document.body.style.color = '\(textColor)';
            
            let elements = document.querySelectorAll('div, p, span, a, h1, h2, h3, h4, h5, h6');
            for (let i = 0; i < elements.length; i++) {
                elements[i].style.backgroundColor = '\(backgroundColor)';
                elements[i].style.color = '\(textColor)';
            }
        })();
        """

        webView.evaluateJavaScript(js, completionHandler: nil)
    }
}
