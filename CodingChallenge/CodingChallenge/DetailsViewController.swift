//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 18/05/23.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {

    private var characterTopic: RelatedTopic!
    private var webContent: WKWebView!
    
    convenience init(relatedTopic: RelatedTopic) {
        self.init()
        self.characterTopic = relatedTopic
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webContent = {
            let modalView = WKWebView()
            modalView.loadHTMLString(self.characterTopic?.result ?? "", baseURL: nil)
            modalView.translatesAutoresizingMaskIntoConstraints = false
            return modalView
        }()
        
        view.addSubview(webContent)
        webContent.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webContent.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webContent.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webContent.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }

}

