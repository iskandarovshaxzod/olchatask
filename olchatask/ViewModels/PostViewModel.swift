//
//  PostViewModel.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//

import Foundation

class ViewModel {
    func fetchData(completion: @escaping (Result<[Post], Error>) -> Void) {
        let group = DispatchGroup()
        var posts = [PostData]()
        var authors = [AuthorData]()
        
        group.enter()
        APIManager.fetchData(from: URL(string: Constants.BASE_URL + Constants.POSTS)!) { (result: Result<[PostData], Error>) in
            switch result {
            case .success(let fetchedPosts):
                posts = fetchedPosts
            case .failure(let error):
                completion(.failure(error))
            }
            group.leave()
        }
        
        group.enter()
        APIManager.fetchData(from: URL(string: Constants.BASE_URL + Constants.AUTHORS)!) { (result: Result<[AuthorData], Error>) in
            switch result {
            case .success(let fetchedAuthors):
                authors = fetchedAuthors
            case .failure(let error):
                completion(.failure(error))
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            var combinedData = [Post]()
            posts.forEach { post in
                if let author = authors.first(where: { $0.id == post.userId }) {
                    combinedData.append(Post(post: post, author: author))
                }
            }
            completion(.success(combinedData))
        }
    }
    
}






