//
//  Presenter.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/18/21.
//

import Foundation
import UIKit
protocol GamesPresentationLogic {
	func showLoader()
	func hideLoader()
	func presentFetchedResults(results:[GameItem],prev:String?,next:String?)
	func presentSearchResults(results:[GameItem],prev:String?,next:String?)
	func presentGameDetails(result:GameItem)
}

class GamesPresenter: GamesPresentationLogic {
	//MARK: - Variables
	weak var logicDisplayer: GamesDisplayLogic?
	
	//MARK: - Methods
	func showLoader() {
		UIApplication.showLoader(true)
	}
	func hideLoader() {
		UIApplication.hideLoader(true)
	}
	func presentFetchedResults(results: [GameItem], prev: String?, next: String?) {
		print("results=\(results)\n prev=\(String(describing: prev))\n next=\(String(describing: next))")
		logicDisplayer?.displayFetchedResults(results: results, prev: prev, next: next)
	}
	func presentSearchResults(results: [GameItem], prev: String?, next: String?) {
		print("results=\(results)\n prev=\(String(describing: prev))\n next=\(String(describing: next))")
		logicDisplayer?.displaySearchResults(results: results, prev: prev, next: next)
	}
	func presentGameDetails(result: GameItem) {
		logicDisplayer?.presentGameDetails(result: result)
	}
}
