//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Mohamed Gamal on 7/6/19.
//  Copyright © 2019 Barmagli. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
  @IBOutlet weak var webView: WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
      
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
  
  @IBAction func close() {
    dismiss(animated: true, completion: nil)
  }
}
