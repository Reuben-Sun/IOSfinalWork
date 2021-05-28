//
//  SearchResultTableViewController.swift
//  CRUD
//
//  Created by 孙政 on 2021/4/18.
//

import UIKit

class SearchResultTableViewController: UITableViewController, UISearchResultsUpdating {
    

    var allNews:[News] = []
    var filterNews:[News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MasterCell")
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterNews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)

        cell.textLabel?.text = filterNews[indexPath.row].title

        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {return}
        if searchString.isEmpty {return}
        
        switch searchController.searchBar.selectedScopeButtonIndex {
        case 0:
            filterNews = allNews.filter{(stu) -> Bool in
                return stu.title.contains(searchString)||stu.passtime.contains(searchString)}
        case 1:
            filterNews = allNews.filter{(stu) -> Bool in
                return stu.title.contains(searchString)}
        case 2:
            filterNews = allNews.filter{(stu) -> Bool in
                return stu.passtime.contains(searchString)}
        default:
            return
        }
        tableView.reloadData()
    }
    

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let detailVC = mainstoryboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
//        let nav = self.presentingViewController?.navigationController
//        detailVC.student = filterStudents[indexPath.row]
//        detailVC.isAdd = false
//        nav?.pushViewController(detailVC, animated: true)
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
}
