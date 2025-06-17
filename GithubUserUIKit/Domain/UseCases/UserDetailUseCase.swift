//
//  UserDetailUseCase.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 9/6/25.
//

import RxSwift

protocol UserDetailUseCase {
    func fetchUserDetail(username: String) -> Single<GithubUserDetail>
}

struct UserDetailUsecaseImpl: UserDetailUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func fetchUserDetail(username: String) -> Single<GithubUserDetail> {
        return repository.getUserDetail(username: username)
    }
}
