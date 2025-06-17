//
//  UserRepositoryImpl.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 17/6/25.
//

import Foundation
import RxSwift

struct UserRepositoryImpl: UserRepository {
    private let apiClient: APIClient
    private let store: UserStore
    
    init(apiClient: APIClient, store: UserStore) {
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
        return store.getAllUsers()
    }
    
    func clean() {
        store.clean()
    }
    
    func add(users: [GitHubUser]) {
        store.add(users: users)
    }
}
