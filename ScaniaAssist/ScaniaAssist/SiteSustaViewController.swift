//
//  SiteSustaViewController.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 17/10/22.
//

import UIKit
import WebKit

class SiteSustaViewController: UIViewController {

    @IBOutlet weak var sobreWebView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: URL? = URL(string: "https://www.scania.com/br/pt/home/about-scania/sustainability.html")
        
        if let value = url {
            self.sobreWebView.load(URLRequest(url: value))
            self.sobreWebView.allowsBackForwardNavigationGestures = true
        }

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
