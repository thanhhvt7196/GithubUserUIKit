//
//  MockUserDetailUseCase.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 9/6/25.
//

import RxSwift
import Foundation
@testable import GithubUserUIKit

final class MockUserDetailUseCase: UserDetailUseCase {
    private let repository: MockUserRepository
    
    init(repository: MockUserRepository) {
        self.repository = repository
    }
    
    func fetchUserDetail(username: String) -> Single<GithubUserDetail> {
        return repository.getUserDetail(username: username)
    }
}
