//
//  ViewController.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//

import UIKit
import SnapKit

class PostsViewController: UIViewController {
    let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    let viewModel = ViewModel()
    var posts     = [Post]()
    var filteredPosts = [Post]()
    var isSearching   = false

    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchPosts()
        initViews()
    }

    func fetchPosts() {
        viewModel.fetchData { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                self?.reloadTable()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initViews() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        searchBar.placeholder = "Qidiring"
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topPadding)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
         
    }
    
    @objc func refreshTable() {
        fetchPosts()
    }
    
    func reloadTable() {
        refreshControl.endRefreshing()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredPosts.count : posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text       = isSearching ? filteredPosts[indexPath.row].author.name : posts[indexPath.row].author.name
        cell.detailTextLabel?.text = isSearching ? filteredPosts[indexPath.row].post.title  : posts[indexPath.row].post.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PostDetailsViewController()
        vc.post = posts[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PostsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPosts = posts.filter { $0.post.title.lowercased().contains(searchText.lowercased()) }
        isSearching = true
        searchBar.showsCancelButton = true
        reloadTable()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.showsCancelButton = false
        reloadTable()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
