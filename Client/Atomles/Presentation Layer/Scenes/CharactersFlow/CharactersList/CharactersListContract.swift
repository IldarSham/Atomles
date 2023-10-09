//
//  CharactersListContract.swift
//  Atomles
//
//  Created by Ildar on 15.09.2022.
//

import Foundation

protocol CharactersListViewProtocol: AnyObject {
    func onFetchCharactersSuccess()
    func onFetchCharactersFailure(error: Error)
}

protocol CharactersListPresenterProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func getCellModel(for index: Int) -> CharacterCellModel
    func didSelectItemAt(index: Int)
}
