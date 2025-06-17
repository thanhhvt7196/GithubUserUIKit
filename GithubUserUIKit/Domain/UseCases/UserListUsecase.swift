//
//  UserListUsecase.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 9/6/25.
//

import RxSwift

protocol UserListUsecase {
    func fetchUsers(perPage: Int, since: Int) -> Single<[GitHubUser]>
    func getAllUsersFromCache() -> [GitHubUser]
    func cleanCache()
    func saveCache(users: [GitHubUser])
}

struct UserListUsecaseImpl: UserListUsecase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func fetchUsers(perPage: Int, since: Int) -> Single<[GitHubUser]> {
        return repository.getUserList(page: since, itemPerPage: perPage)
    }
    
    func getAllUsersFromCache() -> [GitHubUser] {
        return repository.getAllUsers()
    }
    
    func cleanCache() {
        repository.clean()
    }
    
    func saveCache(users: [GitHubUser]) {
        repository.add(users: users)
    }
}
