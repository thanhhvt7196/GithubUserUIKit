//
//  UserListUseCaseTests.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 9/6/25.
//


import XCTest
import RxSwift
import RxBlocking
@testable import GithubUserUIKit

final class UserListUseCaseTests: XCTestCase {
    var mockUserRepository: MockUserRepository!
    var mockUserStore: MockUserStore!
    var useCase: UserListUsecase!
    var mockAPIClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        mockUserStore = MockUserStore()
        mockUserRepository = MockUserRepository(apiClient: mockAPIClient, store: mockUserStore)
        useCase = UserListUsecaseImpl(repository: mockUserRepository)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        mockUserStore = nil
        mockUserRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testFetchUsers_ShouldReturnUsersFromServer() {
        let mockUsers = GitHubUserDTO.mockList()
        mockAPIClient.mockResult = .success(mockUsers)
        
        let result = try? useCase.fetchUsers(perPage: 20, since: 0).toBlocking().single()
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 5)
        XCTAssertEqual(result?.first?.login, "mojombo")
    }
    
    func testGetAllUsers_ShouldReturnUsersFromStore() {
        let mockUsers = GitHubUser.mockList()
        mockUserStore.add(users: mockUsers)
        
        let users = useCase.getAllUsersFromCache()
        
        XCTAssertEqual(users.count, mockUsers.count)
        XCTAssertEqual(users.first?.id, mockUsers.first?.id)
        XCTAssertEqual(users.first?.login, mockUsers.first?.login)
    }
    
    func testFetchUsers_WhenAPIFails_ShouldThrowError() {
        let error = APIError(message: "User list API error")
        mockAPIClient.mockResult = .failure(error)
        
        XCTAssertThrowsError(
            try useCase.fetchUsers(perPage: 20, since: 0).toBlocking().single()
        ) { thrown in
            let apiError = thrown as? APIError
            XCTAssertEqual(apiError?.message, error.message)
        }
    }
    
    func testFetchUsers_ShouldUseCorrectRouter() {
        mockAPIClient.mockResult = .success(GitHubUserDTO.mockList())
        
        _ = try? useCase.fetchUsers(perPage: 20, since: 0).toBlocking().single()

        if case .getGithubUsersList(let perPage, let since) = mockAPIClient.lastRouter {
            XCTAssertEqual(perPage, 20)
            XCTAssertEqual(since, 0)
        } else {
            XCTFail("Wrong router called")
        }
    }
    
    func testClean_ShouldClearStore() {
        useCase.cleanCache()
        
        XCTAssertTrue(useCase.getAllUsersFromCache().isEmpty)
    }
} 
