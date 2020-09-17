//
//  ViewController.swift
//  NewsApiWithMoya
//
//  Created by Lawencon on 02/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import UIKit
import Kingfisher

class NewsViewController: BaseViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
    
    let tableView = UITableView()
    
    var showNewsData : [Articles] = []
    var filteredNewsData : [Articles] = []
    var presenter: NewsViewToPresenterProtocol?
    var searching = false
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCellTableViewCell")
        NewsWireframe.createModule(news: self)
        
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        navigationController?.navigationBar.topItem?.title = "NEWS"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
        presenter?.startFetching(data: newsListRequest.newsParam(q: "sports", from: "2020-09-03", sortBy: "publishedAt", apiKey: "c766e9bd546f46f096873d6b0d53e471"))
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return filteredNewsData.count
        }else{
            return showNewsData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellTableViewCell", for: indexPath) as! NewsCellTableViewCell
        
        if searching{
            cell.titleLbl.text = filteredNewsData[indexPath.row].title
            cell.authorLbl.text = filteredNewsData[indexPath.row].author
            let url = URL(string: filteredNewsData[indexPath.row].urlToImage ?? "")
            cell.newsImg.kf.setImage(with: url, placeholder: UIImage(named: "noImages"), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
            return cell
        }else{
            cell.titleLbl.text = showNewsData[indexPath.row].title
            cell.authorLbl.text = showNewsData[indexPath.row].author
            let url = URL(string: showNewsData[indexPath.row].urlToImage ?? "")
            cell.newsImg.kf.setImage(with: url, placeholder: UIImage(named: "noImages"), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
            return cell
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.isEmpty == true{
            reloadData(choice: false)
            searchBar.text = ""
        }else{
            filteredNewsData = showNewsData.filter({ (data) -> Bool in
                let searchData = data.author?.lowercased().contains(searchText.lowercased())
                return searchData ?? true
            })
            reloadData(choice: true)
        }
        
    }
    
    func reloadData(choice: Bool){
        searching = choice
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailNewsViewController()
        if searching{
            vc.urlDetail = filteredNewsData[indexPath.row].url
        }else{
            vc.urlDetail = showNewsData[indexPath.row].url
        }

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension NewsViewController: NewsPresenterToViewProtocol{
    func showData(data: [Articles]) {
        self.removeSpinner()
        showNewsData = data
        tableView.reloadData()
        
    }
    
    func displayError(message: String) {
        self.removeSpinner()
        AlertView.showAlert(view: self, title: "Error", message: message)
        
    }
    
}
