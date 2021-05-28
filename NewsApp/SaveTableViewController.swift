//
//  SaveTableViewController.swift
//  NewsApp
//
//  Created by 孙政 on 2021/5/28.
//


import UIKit

class SaveTableViewController: UITableViewController {

    let jsonClass = JsonFileManager<News>(fileName: "news")
    var searchercontroller: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRefreshView2()
        jsonClass.Load()
        initSearch()
    }

    func initSearch(){
        let resultController = SearchResultTableViewController()
        resultController.allNews = self.jsonClass.Records
        
        searchercontroller = UISearchController(searchResultsController: resultController)
        let searchBar = searchercontroller.searchBar
        searchBar.scopeButtonTitles = ["所有","标题","时间"]
        searchBar.placeholder = "Enter a search item"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchercontroller.searchResultsUpdater = resultController
        self.definesPresentationContext = true
    }
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonClass.Records.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            jsonClass.Records.remove(at: indexPath.row)
            jsonClass.Save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)

        let new = jsonClass.Records[indexPath.row]
        cell.textLabel?.text = new.title
        cell.detailTextLabel?.text = new.passtime
        
        return cell
    }
    

    override func viewWillAppear(_ animated: Bool) {    //重新加载时要刷新
        tableView.reloadData()
    }
    
    func setRefreshView2()
    {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshData2), for: .valueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.refreshData2()
    }
    
    // 刷新数据
    @objc func refreshData2() {
        jsonClass.Load()
        tableView.reloadData()
        
        self.refreshControl!.endRefreshing()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //转场
//
//    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
//
//        guard let detailViewController = segue.source as? DetailViewController else {return}
//        if detailViewController.isAdd == true{
//            jsonClass.Records.append(detailViewController.student!)
//        }
//        jsonClass.Save()
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? NewsViewController
        {
            dest.news = jsonClass.Records[tableView.indexPathForSelectedRow!.row]
        }
    }

}
