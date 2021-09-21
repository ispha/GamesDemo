//
//  Models.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/18/21.
//

import Foundation
struct Genre: Codable {
	var id, games_count : Int?
	var name, slug, background_image : String?
}
struct Game: Codable {
	var id, metacritic : Int?
	var name, background_image,description,reddit_url,website : String?
	var genres : [Genre]?
	var rating : Double?
}
struct GamesResponse: Codable {
	var next, previous : String?
	var count: Int?
	var results:[Game]?
}
struct GameItem: Codable
{
	var id, metacritic : Int?
	var name, background_image,description,reddit_url,website : String?
	var genres : String?
	var rating : Double?
}
