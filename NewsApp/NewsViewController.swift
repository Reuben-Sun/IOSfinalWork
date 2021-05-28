//
//  NewsViewController.swift
//  NewsApp
//
//  Created by 孙政 on 2021/5/26.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {
    
    var news:News?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: news!.path)
        let request = URLRequest(url: url!)
        webView.load(request)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func favorites(_ sender: Any) {
        
        let jsonClass = JsonFileManager<News>(fileName: "news")
        jsonClass.Load()
        jsonClass.Records.append(news!)
        jsonClass.Save()
        
        let alert = UIAlertController(title: "提示", message: "收藏成功", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in self.navigationController?.popViewController(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    
}
