//
//  DetailsPresenter.swift
//  Profiles-MVP-CoreData
//
//  Created by Roman Korobskoy on 13.08.2022.
//

import Foundation

protocol DetailsPresenterProtocol {
    var reload: (() -> Void)? { get set }
    func saveData()
    func getData()
}

final class DetailsPresenter: DetailsPresenterProtocol {
    var user = UserInfo()
    var reload: (() -> Void)?

    func saveData() {

    }

    func getData() {
        
    }

    func editData(index: Int,
                  name: String?,
                  birthday: String?,
                  gender: String?) {
        CoreDataService.shared.editObject(index: index,
                                          name: name ?? "",
                                          birthday: birthday ?? "",
                                          gender: gender ?? "")
    }
}
