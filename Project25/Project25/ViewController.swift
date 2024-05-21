//
//  ViewController.swift
//  Project25
//
//  Created by leticia.dayane on 20/05/24.
//

import MultipeerConnectivity
import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate {
    var images = [UIImage]()
    
    //adicionar a estrutura multipeer
    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Selfie Share"
        
        let connectionButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        let importPictureButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        //challenge 2
        let sendTextButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(sendText))
        //challenge 3
        let peerControllerButton = UIBarButtonItem(title: "Peers", style: .plain, target: self, action: #selector(peerController))
        
        
        navigationItem.rightBarButtonItems = [importPictureButton, sendTextButton]
        navigationItem.leftBarButtonItems = [connectionButton, peerControllerButton]
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    //challenge 2
    @objc func sendText() {
        let ac = UIAlertController(title: "Send your text here", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Send", style: .default) { _ in
            if let text = ac.textFields![0].text {
                let data = Data(text.utf8)
                self.sendData(data)
            }
        })
        present(ac, animated: true)
    }
    
    //challenge 3
    @objc func peerController() {
        var peersText = ""
        
        var peersAvailable = false
        if let mcSession = mcSession {
            if mcSession.connectedPeers.count > 0 {
                peersAvailable = true
                for peer in mcSession.connectedPeers {
                    peersText += "\n\(peer.displayName)"
                }
            }
        }
        
        if !peersAvailable {
            peersText += "No peer connected"
        }
        
        let ac = UIAlertController(title: "Connected peers", message: peersText, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    //fazer a conexão
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func startHosting(action: UIAlertAction) {
        mcNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "hws-project25")
        mcNearbyServiceAdvertiser.delegate = self
        mcNearbyServiceAdvertiser.startAdvertisingPeer()
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    //fazer com a classe de Nearby esteja em conformidade com o protocolo
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Invitation Received"
        
        let ac = UIAlertController(title: appName, message: "\(peerID.displayName) wants to connect.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Decline", style: .cancel) { [weak self] _ in invitationHandler(false, self?.mcSession)})
        ac.addAction(UIAlertAction(title: "Accept", style: .default) { [weak self] _ in invitationHandler(true, self?.mcSession)})
        present(ac, animated: true)
    }
    
    //configura a visualização de coleção
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //configura a visualização de coleção
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
    
    //lida com o seletor de imagens
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    //lida com o seletor de imagens
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        
        if let imageData = image.pngData() {
            sendText()
        }
    }
    
    func sendData(_ data: Data) {
        guard let mcSession = mcSession else { return }
        
        if mcSession.connectedPeers.count > 0 {
                do {
                    try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
            }
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")
            
        case .connecting:
            print("Connecting: \(peerID.displayName)")
            
        case .notConnected:
            //challenge 1
            let ac = UIAlertController(title: "\(peerID.displayName) has disconnected.", message: "The connection has been interrupted.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            DispatchQueue.main.async {
                self.present(ac, animated: true)
            }
            
        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async { [weak self] in
            if let image = UIImage(data: data) {
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
            } else {
                //challenge 2
                let text = String(decoding: data, as: UTF8.self)
                let ac = UIAlertController(title: "Message received", message: "\n\(text)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: (any Error)?) {
        
    }
    
    //descartar o controlador de visualização
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
}


