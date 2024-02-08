//
//  DetailViewController.swift
//  Project7
//
//  Created by leticia.dayane on 26/01/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView! //desempacotamento forçado
    var detailItem: Petition? //necessário desempacotar usando if let ou guard let
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name"viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 250%; text-align: justify; padding: 10px; }  </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
