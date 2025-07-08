//
//  MockUserRepository.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 9/6/25.
//


import Foundation
import RxSwift
@testable import GithubUserUIKit

class MockUserRepository: UserRepository {
    private let apiClient: MockAPIClient
    private let store: UserStore
    
    init(apiClient: MockAPIClient, store: MockUserStore) {
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
