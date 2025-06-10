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
    private let userService: MockUserService
    
    init(userService: MockUserService) {
        self.userService = userService
    }
    
    func fetchUserDetail(username: String) -> Single<GithubUserDetail> {
        return userService.getUserDetail(username: username)
    }
}
