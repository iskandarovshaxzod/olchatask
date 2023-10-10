//
//  SavedPostsViewController.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//

import UIKit

class SavedPostsViewController: UIViewController {
    
    let tableView  = UITableView()
    var savedPosts = [SavedPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSavedPosts()
    }
    
    func fetchSavedPosts() {
        CoreDataManager.getAllPosts { [weak self] result in
            switch result {
            case .success(let savedPosts):
                self?.savedPosts = savedPosts
            case .failure(let error):
                print(error)
            }
        }
        updateTable()
    }
    
    func updateTable() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func initViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
}

extension SavedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPosts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text       = savedPosts[indexPath.row].authorName
        cell.detailTextLabel?.text = savedPosts[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "O'chirish") { [weak self] (_, _, _) in
            guard let post = self?.savedPosts[indexPath.row] else { return }
            CoreDataManager.deletePost(post: post)
            self?.fetchSavedPosts()
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
