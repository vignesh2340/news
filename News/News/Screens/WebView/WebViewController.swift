//
//  WebViewController.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    var news: PapularNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewContent()
    }
    
    func setViewContent() {
        title = news?.title ?? ""
        let myURLString = news?.url ?? ""
        if let url = URL(string: myURLString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    
}
