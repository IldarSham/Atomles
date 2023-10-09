//
//  SeriesListPresenter.swift
//  Atomles
//
//  Created by Ildar on 10.06.2022.
//

import Foundation

class SeriesListPresenter {
    
    // MARK: - Properties
    weak var view: SeriesListViewProtocol!
    private let seriesService: SeriesServiceProtocol
    private let storageService: WatchedSeriesStorageService
    private let coordinator: SeriesListCoordinatorProtocol
    
    let loadingTableViewProvider = LoadingTableViewProvider()
        
    var fetchedData = [SeriesModel]()
    var displayedData = [SeriesListCellModel]()
    
    // MARK: - Initialization
    init(view: SeriesListViewProtocol,
         seriesService: SeriesServiceProtocol,
         storageService: WatchedSeriesStorageService,
         coordinator: SeriesListCoordinatorProtocol) {
        
        self.view = view
        self.seriesService = seriesService
        self.storageService = storageService
        self.coordinator = coordinator
    }
    
    // MARK: - Public Methods
    func fetchListOfSeries() {
        seriesService.getAllSeries { (result: Result<[SeriesModel]>) in
            switch result {
            case .success(let series):
                self.fetchSeriesListSuccess(series: series)
            case .failure(let error):
                self.fetchSeriesListFailure(error: error)
            }
        }
    }
    
    func fetchSeriesListSuccess(series: [SeriesModel]) {
        fetchedData = series
        displayedData = convertToViewModel(series: series)
        view.onFetchSeriesListSuccess()
    }
    
    func fetchSeriesListFailure(error: Error) {
        view.onFetchSeriesListFailure(error)
    }
    
    func convertToViewModel(series: [SeriesModel]) -> [SeriesListCellModel] {
        return series.map {
            SeriesListCellModel(
                title: $0.title,
                season: SeasonsHorizontalMenuViewModel(season: $0.season),
                subtitle: "\($0.season) сезон, \($0.episode) серия",
                previewImageUrl: $0.previewImageUrl,
                description: $0.description,
                isWatched: isWatched($0.id)
            )
        }
    }
    
    func setLoadingTableView() {
        view.setTableViewProvider(loadingTableViewProvider)
        view.reloadData()
    }
    
    func isWatched(_ episodeId: Int) -> Bool {
        let watchedSeriesIds = storageService.getWatchedEpisodeIds()
        return watchedSeriesIds.contains(episodeId)
    }
    
    func toggleWatchedStatusInStorage(_ episodeId: Int) {
        if !isWatched(episodeId) {
            storageService.markEpisodeAsWatched(episodeId)
        } else {
            storageService.unmarkEpisodeAsWatched(episodeId)
        }
    }

    func setWatchedStatus(index: Int) {
        displayedData[index].isWatched.toggle()
        toggleWatchedStatusInStorage(fetchedData[index].id)
    }
}

// MARK: - Presenter Protocol
extension SeriesListPresenter: SeriesListPresenterProtocol {
    
    func viewDidLoad() {
        setLoadingTableView()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.fetchListOfSeries()
        }
    }
    
    func numberOfSections() -> Int {
        return displayedData.count
    }
    
    func getCellModel(for index: Int) -> SeriesListCellModel {
        return displayedData[index]
    }
    
    func didSelectRow(at index: Int) {
        coordinator.pushToSeriesDetail(with: fetchedData[index])
    }
    
    func handleWatchedButtonTap(at index: Int) {
        setWatchedStatus(index: index)
        view.reloadSections([index])
    }
    
    func sectionIndexForMenuItem(_ item: SeasonsHorizontalMenuViewModel) -> Int? {
        return displayedData.firstIndex { $0.season == item }
    }
    
    func menuItemForSectionIndex(_ index: Int) -> SeasonsHorizontalMenuViewModel? {
        return displayedData[index].season
    }
}
