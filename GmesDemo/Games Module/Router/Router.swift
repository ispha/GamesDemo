//
//  Router.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/18/21.
//

import Foundation
protocol GamesRoutingLogic {
	func routeToDetailsPage(gameID:Int)
}

class GamesRouter: GamesRoutingLogic {

	//MARK: - Variables
	 var gamesListViewController: GamesListViewController?
	 var gameDetailsViewController: GameDetailsViewController?

	func routeToDetailsPage(gameID:Int) {
		gameDetailsViewController = GameDetailsViewController(nibName: gameDetailsViewController?.nibName, bundle: nil)
		gameDetailsViewController?.gameID = gameID
		gamesListViewController?.show(gameDetailsViewController!, sender: nil)
	}
}
