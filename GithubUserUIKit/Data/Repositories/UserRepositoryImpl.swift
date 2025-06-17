//
//  UserRepositoryImpl.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 17/6/25.
//

import Foundation
import RxSwift

struct UserRepositoryImpl<C: Storeable>: UserRepository where C.Model == GitHubUser {
    private let apiClient: APIClient
    private let store: C
    
    init(apiClient: APIClient, store: C) {
        self.apiClient = apiClient
        self.store = store
    }
    
    func getUserList(page: Int, itemPerPage: Int) -> Single<[GitHubUser]> {
        return apiClient.request(router: .getGithubUsersList(itemPerPage: itemPerPage, since: page), type: [GitHubUserDTO].self).map { $0.map { $0.toDomain() }}
    }
    
    func getUserDetail(username: String) -> Single<GithubUserDetail> {
        return apiClient.request(router: .getUserDetails(username: username), type: GithubUserDetailDTO.self).map { $0.toDomain() }
    }
    
    func getAllUsers() -> [GitHubUser] {
        let sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return store.objects(nil, sort: sortDescriptors)
    }
    
    func clean() {
        store.add([], update: .cleanOnUpdate)
    }
    
    func add(users: [GitHubUser]) {
        store.add(users, update: .update)
    }
}
