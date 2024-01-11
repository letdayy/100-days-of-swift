//
//  ViewController.swift
//  Project4
//
//  Created by leticia.dayane on 11/01/24.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    //forçar o desempacotamento de WebView
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    //função principal
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


}

