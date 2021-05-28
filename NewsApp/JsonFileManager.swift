//
//  JsonFileManager.swift
//  NewsApp
//
//  Created by 孙政 on 2021/5/28.
//


import Foundation

class JsonFileManager<T: NSObject&Codable>
{
    var Records:[T] = []
    
    var Url:URL
    
    init(fileName:String){
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        Url = path.appendingPathComponent(fileName)
        print(Url.path)
    }
    
    func Save()
    {
        let encoder = JSONEncoder()
        do
        {
            let encodeData: Data? = try encoder.encode(Records)
            try encodeData!.write(to: Url, options: .atomic)
        }
        catch
        {
            print(error)
        }
    }
    
    func Load()
    {
        do
        {
            if let encodeData = try? Data.init(contentsOf: Url){
                let decoder = JSONDecoder()
                Records = try decoder.decode([News].self, from: encodeData) as![T]
            }
        }
        catch
        {
            print(error)
        }
    }
}
