//
//  PostData.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//

import Foundation

struct PostData: Codable {
    let userId: Int64
    let id: Int64
    let title: String
    let body: String
}
