//
//  Fetcher.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/18/21.
//

import Combine
import Foundation
protocol GamesFetchingLogic {
	func fetchGamesList(index:Int)-> AnyPublisher<GamesResponse, Error>
	func fetchSearchResultsForKey(key:String,index:Int)-> AnyPublisher<GamesResponse, Error>
	func fetchGameDetailsWithGameID(gameID:Int)-> AnyPublisher<Game, Error>
}
class GamesFetcher:GamesFetchingLogic
{

	func fetchGamesList(index: Int)-> AnyPublisher<GamesResponse, Error> {
		let request = URLRequest(url: URL(string: Constants.EndpointsConfigs.DOMAIN_ENDPOINT + Constants.EndpointsConfigs.GamesEndPoint.replacingOccurrences(of: "{page}", with: "\(index)"))!)
		return ApiClient().make(request)
	}

	func fetchSearchResultsForKey(key: String, index: Int)-> AnyPublisher<GamesResponse, Error> {
		let request = URLRequest(url: URL(string: Constants.EndpointsConfigs.DOMAIN_ENDPOINT + Constants.EndpointsConfigs.SearchEndPoint.replacingOccurrences(of: "{page}", with: "\(index)").replacingOccurrences(of: "{key}", with: key))!)
		return ApiClient().make(request)
	}

	func fetchGameDetailsWithGameID(gameID: Int) -> AnyPublisher<Game, Error> {
		let request = URLRequest(url: URL(string: Constants.EndpointsConfigs.DOMAIN_ENDPOINT + Constants.EndpointsConfigs.GameDetailsEndPoint.replacingOccurrences(of: "{gameID}", with: "\(gameID)"))!)
		return ApiClient().make(request)
	}
}
struct ApiClient {

	func make<T: Decodable>(
		_ request: URLRequest,
		_ decoder: JSONDecoder  = .init()
	) -> AnyPublisher<T, Error> {
		URLSession.shared
			.dataTaskPublisher(for: request)
			.map(\.data)
			.decode(type: T.self, decoder: decoder)
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}

}
