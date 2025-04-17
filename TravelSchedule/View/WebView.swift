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
        let js = """
        (function() {
            let darkMode = \(isDarkMode ? "true" : "false");
            
            if (darkMode) {
                document.body.style.backgroundColor = '#1A1B22';
                document.body.style.color = '#FFFFFF';
            } else {
                document.body.style.backgroundColor = '#FFFFFF';
                document.body.style.color = '#000000';
            }
        })();
        """

        webView.evaluateJavaScript(js, completionHandler: nil)
    }
}
