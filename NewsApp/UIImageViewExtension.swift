//
//  UIImageViewExtension.swift
//  NewsApp
//
//  Created by 孙政 on 2021/5/28.
//

import UIKit

extension UIImageView{
    func downloadAsyncFrom(url:String){
        let urlNet = URL(string: url)
        let task = URLSession.shared.dataTask(with: urlNet!)
        {
            (data, response, error) in
            if let nsd = data{
                DispatchQueue.main.async {
                    self.image = UIImage(data: nsd, scale: 1)
                    self.contentMode = .scaleAspectFit
                }
            }
        }
        task.resume()
        
    }
}
