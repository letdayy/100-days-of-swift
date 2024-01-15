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
    //propriedade da barra de progresso
    var progressView: UIProgressView!
    //array de sites vazio
    var websites: [String]!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    //função principal
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //coloca um espaço em branco em toda a barra de navegação jogando o botão para a direita
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //ícone de recarregar página
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        //botões do desafio
        let back = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(goBack))
        let foward = UIBarButtonItem(title: "Avançar", style: .plain, target: self, action: #selector(goForward))
        
                
        //código da barra de progresso
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [back, progressButton, spacer, refresh, foward]
        navigationController?.isToolbarHidden = false
        
        //adicionando o observador para saber o carregamento da página na barra de progresso
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    //funçoes do desafio: voltar
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    //funçoes do desafio: avançar
    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    //criação da função para mostrar o quanto da página está sendo carregado
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        progressView.progress = Float(webView.estimatedProgress)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains("google.com") {
                    showAlertBlockAcess()
                    decisionHandler(.cancel)
                    return
                    
                } else if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    
    
    //desafio alerta de site bloqueado
    func showAlertBlockAcess() {
        print("funcao funcionando")
        let alert = UIAlertController(title: "Acesso bloqueado", message: "Não é possível acessar esse site ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

