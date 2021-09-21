//
//  Interactor.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/18/21.
//

import Foundation
import Combine
protocol GamesInteractionLogic {
	func fetchGamesList(index:Int)
	func fetchSearchResults(key:String,index:Int)
	func fetchGameDetails(gameID:Int)
}

class GamesInteractor: GamesInteractionLogic {

	//MARK: - Variables
	var presenter:GamesPresentationLogic?
	var fetcher: GamesFetchingLogic?
	var publisher: AnyPublisher<GamesResponse, Error>? = nil
	var detailsPublisher: AnyPublisher<Game, Error>? = nil
	var cancellable: Cancellable? = nil
	
	//MARK: - Methods
	func fetchGamesList(index: Int) {
		presenter?.showLoader()
		publisher = fetcher?.fetchGamesList(index: index)
		cancellable = publisher!.sink(
			receiveCompletion: { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):

					print(error.localizedDescription)
				}
				self.presenter?.hideLoader()
			},
			receiveValue: { [self] in
				self.presenter?.hideLoader()
				print("results=\(String(describing: $0.results ?? []))")
				let games = getArrayOfGameItems(arrOfGames: $0.results ?? [])
				Storage.store(games , to: .documents, as: Constants.GamesOffline)
				presenter?.presentFetchedResults(results: games, prev: $0.previous, next: $0.next)
			}
		)
	}
	func fetchSearchResults(key:String,index: Int) {
		publisher = fetcher?.fetchSearchResultsForKey(key:key , index: index)
		cancellable = publisher!.sink(
			receiveCompletion: { completion in
				switch completion {
				case .finished:
					self.presenter?.hideLoader()
					break
				case .failure(let error):
					self.presenter?.hideLoader()
					print(error.localizedDescription)
				}
			},
			receiveValue: { [self] in
				self.presenter?.hideLoader()
				print("results=\(String(describing: $0.results ?? []))")
				presenter?.presentSearchResults(results: getArrayOfGameItems(arrOfGames: $0.results ?? []), prev: $0.previous, next: $0.next)
			}
		)
	}
	func fetchGameDetails(gameID: Int) {
		detailsPublisher = fetcher?.fetchGameDetailsWithGameID(gameID: gameID)
		cancellable = detailsPublisher!.sink(
			receiveCompletion: { completion in
				switch completion {
				case .finished:
					self.presenter?.hideLoader()
					break
				case .failure(let error):
					self.presenter?.hideLoader()
					print(error.localizedDescription)
				}
			},
			receiveValue: { [self] in
				self.presenter?.hideLoader()
				print("result=\(String(describing: $0))")
				presenter?.presentGameDetails(result: GameItem(id: $0.id, metacritic: $0.metacritic, name: $0.name, background_image: $0.background_image, description: $0.description, reddit_url: $0.reddit_url, website: $0.website, genres: "", rating: $0.rating))
			}
		)
	}
	func getArrayOfGameItems(arrOfGames:[Game])->[GameItem]
	{
		var arrOfGameItems = [GameItem]()
		for game in arrOfGames
		{
			var genresNames = ""
			for genre in game.genres ?? []
			{
				genresNames.append(genresNames == "" ? "" : ",")
				genresNames.append(genre.name ?? "")
			}
			arrOfGameItems.append(GameItem(id: game.id, metacritic: game.metacritic, name: game.name, background_image: game.background_image, genres: genresNames, rating: game.rating))
		}
		return arrOfGameItems
	}
}
