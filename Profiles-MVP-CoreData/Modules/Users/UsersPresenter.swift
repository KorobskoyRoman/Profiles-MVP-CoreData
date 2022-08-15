//
//  UsersPresenter.swift
//  Profiles-MVP-CoreData
//
//  Created by Roman Korobskoy on 13.08.2022.
//

import Foundation

protocol UsersPresenterProtocol {
    var reload: (() -> Void)? { get set }
    func saveData(from text: String)
    func getData()
}

class UsersPresenter: UsersPresenterProtocol {
    var reload: (() -> Void)?
    var users = [UserInfo]()
    var usersCount: Int {
        users.count
    }

    func user(at index: Int) -> UserInfo {
        users[index]
    }

    func saveData(from text: String) {
        CoreDataService.shared.uploadIntoCoreData(from: text)
    }

    func getData() {
        users = CoreDataService.shared.getUsersFromCoreData()
        self.reload?()
    }

    func delete(at indexPath: Int) {
//        users.remove(at: indexPath)
        CoreDataService.shared.deleteObject(array: users, indexPath: indexPath)
        users.remove(at: indexPath)
    }
}
