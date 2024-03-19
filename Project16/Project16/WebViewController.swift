//
//  WebViewController.swift
//  Project16
//
//  Created by leticia.dayane on 19/03/24.
//
//challenge 3
import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        view = webView
        
        if let urlString = urlString,
           let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
            
            // Do any additional setup after loading the view.
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
}
