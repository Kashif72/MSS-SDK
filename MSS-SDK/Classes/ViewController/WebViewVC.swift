//
//  WebViewVC.swift
//  MSS-SDK
//
//  Created by Kashif Imam on 15/10/20.
//  Copyright © 2020 Kashif Imam. All rights reserved.
//

import UIKit
import WebKit


class WebViewVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var avLoader: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    var webUrl = ""
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        avLoader.startAnimating()
        avLoader.isHidden = false
        let myURL = URL(string: webUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: false)
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            avLoader.stopAnimating()
            avLoader.isHidden = true
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            avLoader.stopAnimating()
            avLoader.isHidden = true
        }
        
        func webViewDidFinishLoad(_ : WKWebView) {
            avLoader.stopAnimating()
            avLoader.isHidden = true
        }
        

    }

