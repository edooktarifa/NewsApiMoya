//
//  DetailNewsViewController.swift
//  NewsApiWithMoya
//
//  Created by Lawencon on 03/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import UIKit
import WebKit

class DetailNewsViewController: BaseViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var urlDetail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: urlDetail ?? "")
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.removeSpinner()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.removeSpinner()
    }

}
