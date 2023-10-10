//
//  CoreDataManager.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static func getAllPosts(completion: @escaping ((Result<[SavedPost], Error>) -> Void)) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let savedPosts = try context.fetch(SavedPost.fetchRequest())
            completion(.success(savedPosts))
        } catch {
            completion(.failure(error))
            print(error)
        }
    }
    
    static func savePost(postID: Int64, authorID: Int64, authorName: String, body: String, title: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let post = SavedPost(context: context)
        
        post.setValue(postID,     forKey: "postID")
        post.setValue(authorID,   forKey: "authorID")
        post.setValue(authorName, forKey: "authorName")
        post.setValue(body,       forKey: "body")
        post.setValue(title,      forKey: "title")
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func deletePost(post: SavedPost) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(post)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
