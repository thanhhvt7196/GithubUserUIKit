//
//  UserStore.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 17/6/25.
//

import RealmSwift
import Foundation

protocol UserStore {
    func getAllUsers() -> [GitHubUser]
    func clean()
    func add(users: [GitHubUser])
}

struct UserStoreImpl<C: Storeable>: UserStore where C.Model == GitHubUser {
    private let collection: C
    
    init(collection: C) {
        self.collection = collection
    }
    
    func getAllUsers() -> [GitHubUser] {
        let sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

        return collection.objects(nil, sort: sortDescriptors)
    }

    func clean() {
        collection.add([], update: .cleanOnUpdate)
    }
    
    func add(users: [GitHubUser]) {
        collection.add(users, update: .update)
    }
}
