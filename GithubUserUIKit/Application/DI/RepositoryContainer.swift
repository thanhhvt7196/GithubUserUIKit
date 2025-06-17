//
//  RepositoryContainer.swift
//  GithubUserUIKit
//
//  Created by thanh tien on 2/6/25.
//

import Swinject
import RealmSwift

struct RepositoryContainer: DIContainer {
    private static let sharedRealmConfig: Realm.Configuration = {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = 1
        config.deleteRealmIfMigrationNeeded = false
        if let url = config.fileURL {
            let fileUrl = url.deletingLastPathComponent().appendingPathComponent("github_user.realm")
            config.fileURL = fileUrl
        }
        return config
    }()
    
    static var container: Container {
        let container = Container()
        
        container.register(APIClient.self) { _ in
            APIClientImpl()
        }
        .inObjectScope(.transient)
        
        container.register(RealmStore<GithubUserRealm>.self) { _ in
            RealmStore<GithubUserRealm>(config: sharedRealmConfig, label: "UserStore")
        }
        .inObjectScope(.container)
        
        container.register(UserRepository.self) { _ in
            guard let apiClient = container.resolve(APIClient.self) else {
                fatalError("Failed to resolve APIClient")
            }
            
            guard let store = container.resolve(RealmStore<GithubUserRealm>.self) else {
                fatalError("Failed to resolve UserStore")
            }
            
            return UserRepositoryImpl(apiClient: apiClient, store: store)
        }
        .inObjectScope(.transient)
        
        return container
    }
}
