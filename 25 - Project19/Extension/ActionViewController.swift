//
//  ActionViewController.swift
//  Extension
//
//  Created by leticia.dayane on 08/04/24.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    var pageTitle = ""
    var pageURL = ""

    @IBOutlet weak var script: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        //challenge 1
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Select Script", style: .plain, target: self, action: #selector(selectScript))
        
        //challenge 2, para ler o script salvo na página
        if let url = URL(string: pageURL), let savedScript = UserDefaults.standard.string(forKey: url.host ?? "") {
            script.text = savedScript
        }
    
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: UTType.propertyList.identifier as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    //challenge 1
    @objc func selectScript() {
        let ac = UIAlertController(title: "Select script", message: nil, preferredStyle: .actionSheet)
        let scripts = ["alert(document.title);", "document.body.style.backgroundColor = 'lightblue';", "var newElement = document.createElement('p'); newElement.innerText = 'Novo parágrafo aqui'; document.body.appendChild(newElement);"]
        
        for scriptTitle in scripts {
            ac.addAction(UIAlertAction(title: scriptTitle, style: .default) { [weak self] _ in
                self?.script.text = scriptTitle
                self?.saveScript()
                self?.done()
            })
                }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(ac, animated: true)
    }

    @IBAction func done() {
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
        
        //retornar texto digitado pelo usuário:
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text ?? ""]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: UTType.propertyList.identifier as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    //challenge 2, para salvar o script com UserDefaults
    func saveScript() {
        if let url = URL(string: pageURL) {
            UserDefaults.standard.setValue(script.text, forKey: url.host ?? "")
        }
    }
}
