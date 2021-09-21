//
//  Constants.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/19/21.
//

import Foundation
struct Constants{
	//foursquare api Secret ID
	static let API_KEY = "3be8af6ebf124ffe81d90f514e59856c"
	static let PageSize = 10
	static var GamesOffline = "GamesOffline"
	static var FavouriteGames = "FavouriteGames"
	struct EndpointsConfigs
	{
		static let DOMAIN_ENDPOINT = Environment.rootURLString
		static let GamesEndPoint = "games?page_size=\(Constants.PageSize)&page={page}&key=\(Constants.API_KEY)"
		static let SearchEndPoint = "games?page_size=\(Constants.PageSize)&page={page}&key=\(Constants.API_KEY)&search={key}"
		static let GameDetailsEndPoint = "games/{gameID}?key=\(Constants.API_KEY)"
	}


	struct Colors {
		static let blueColor = "#1064BC"
	}
	struct  StoryboardIDs {
		static let Main = "Main"
	}
	struct StoryboardVCsIDs
	{
		static let ArticleDetailsViewController = "ArticleDetailsViewController"
	}

}
