//
//  News.swift
//  NewsApp
//
//  Created by 孙政 on 2021/5/22.
//

import Foundation

class News:NSObject, Codable
{
    var title:String = ""
    var path:String = ""
    var passtime:String = ""
    var image:String = ""
    
    private enum CodingKeys: String, CodingKey{
        case title
        case path
        case passtime
        case image
    }
    
    init(title:String)
    {
        self.title = title
    }
    
    override var description: String {
        return "title:\(title)"
    }
}

class NewsResponse:NSObject, Codable
{
    var code:Int=0
    var result:[News] = []
    var message:String = ""
   
    private enum CodingKeys: String, CodingKey{
        case code
        case result
        case message
    }
}

class NewsManager
{
    static let shared:NewsManager = NewsManager()
    
    var news:[News] = []
    var curPage:Int = 1
    var pageSize = 10
    
    func fetchMore( complete:@escaping ()->Void) {
        curPage += 1
        fetchData(complete: complete)
    }
    
    func refresh( complete:@escaping  ()->Void)  {
        news.removeAll()
        curPage = 1
        fetchData(complete: complete)
    }
    
    private func fetchData(complete: @escaping ()->Void)
    {
        //"http://zy.whu.edu.cn/news/api/news/getList?page=\(curPage)&count=\(pageSize)"
        //"https://api.apiopen.top/getWangYiNews?page=\(curPage)&count=\(pageSize)"
        let url = URL(string: "https://api.apiopen.top/getWangYiNews?page=\(curPage)&count=\(pageSize)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let moreNews = try? JSONDecoder().decode(NewsResponse.self, from:data)
                {
                    moreNews.result.forEach{self.news.append($0)}
                    //print(moreNews.result)
                    //Thread.sleep(forTimeInterval: 5)
                    complete()
            }
        }
        task.resume()
    }
}
