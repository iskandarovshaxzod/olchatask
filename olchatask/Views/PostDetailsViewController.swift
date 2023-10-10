//
//  PostDetailsViewController.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//

import UIKit
import SnapKit

class PostDetailsViewController: UIViewController {
    
    var post: Post? = nil
    
    let authorLabel = UILabel()
    let titleLabel  = UILabel()
    let bodyLabel   = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        initViews()
    }
    
    func initNavigation() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonTapped() {
        CoreDataManager.savePost(postID: post?.post.id ?? 0,
                                 authorID: post?.author.id ?? 0,
                                 authorName: post?.author.name ?? "",
                                 body: post?.post.body ?? "",
                                 title: post?.post.title ?? "")
    }
    
    func initViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        authorLabel.textAlignment = .center
        authorLabel.font = .boldSystemFont(ofSize: 30)
        authorLabel.text = post?.author.name
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        titleLabel.textAlignment = .center
        titleLabel.text  = post?.post.title
        titleLabel.numberOfLines = 0
        
        view.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        bodyLabel.textAlignment = .center
        bodyLabel.text  = post?.post.body
        bodyLabel.numberOfLines = 0
    }
    
}
