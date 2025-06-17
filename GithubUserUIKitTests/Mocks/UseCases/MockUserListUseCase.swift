//
//  MockUserListUseCase.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 9/6/25.
//

import Foundation
import RxSwift
@testable import GithubUserUIKit

final class MockUserListUseCase: UserListUsecase {
    private let repository: MockUserRepository
    
    
    init(repository: MockUserRepository) {
        self.repository = repository
    }
    
    func fetchUsers(perPage: Int, since: Int) -> Single<[GitHubUser]> {
        return repository.getUserList(page: since, itemPerPage: perPage)
    }
    
    func getAllUsersFromCache() -> [GitHubUser] {
        return repository.getAllUsers()
    }
    
    func cleanCache() {
        return repository.clean()
    }
    
    func saveCache(users: [GitHubUser]) {
        return repository.add(users: users)
    }
}
