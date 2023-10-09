//
//  CharacterDetailContract.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 07.11.2022.
//

import Foundation

protocol CharacterDetailViewProtocol: AnyObject {
    func setNavigationTitle(title: String)
    func onFetchCharacterDetailSuccess()
    func onFetchCharacterDetailFailure(error: Error)
}

protocol CharacterDetailPresenterProtocol {
    func viewDidLoad()
    func getGalleryCellModel() -> GalleryCellViewModel?
    func getDescriptionCellModel() -> DescriptionCellViewModel?
}
