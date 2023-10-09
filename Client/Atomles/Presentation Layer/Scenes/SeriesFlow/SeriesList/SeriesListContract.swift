//
//  SeriesListContract.swift
//  Atomles
//
//  Created by Ildar on 11.09.2022.
//

import Foundation
import UIKit

protocol SeriesListViewProtocol: AnyObject {
    func onFetchSeriesListSuccess()
    func onFetchSeriesListFailure(_ error: Error)
    func reloadData()
    func reloadSections(_ sections: IndexSet)
    func setTableViewProvider(_ provider: TableViewProvider)
}

protocol SeriesListPresenterProtocol {
    func viewDidLoad()
    func numberOfSections() -> Int
    func getCellModel(for index: Int) -> SeriesListCellModel
    func didSelectRow(at index: Int)
    func handleWatchedButtonTap(at index: Int)
    func sectionIndexForMenuItem(_ item: SeasonsHorizontalMenuViewModel) -> Int?
    func menuItemForSectionIndex(_ index: Int) -> SeasonsHorizontalMenuViewModel?
}
