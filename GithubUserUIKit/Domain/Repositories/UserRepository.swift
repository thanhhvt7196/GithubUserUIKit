//
//  UserRepository.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 9/6/25.
//

import RxSwift

protocol UserRepository {
    func getUserList(page: Int, itemPerPage: Int) -> Single<[GitHubUser]>
    func getUserDetail(username: String) -> Single<GithubUserDetail>
    func getAllUsers() -> [GitHubUser]
    func clean()
    func add(users: [GitHubUser])
}
