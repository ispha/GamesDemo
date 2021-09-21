//
//  GameDetailsViewController.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/20/21.
//

import UIKit
import SafariServices
class GameDetailsViewController: UIViewController {

	//MARK: - Outlets
	@IBOutlet weak var imgV_backgroundImage:UIImageView!
	@IBOutlet weak var lbl_name:UILabel!
	@IBOutlet weak var btn_Favourite:UIButton!
	@IBOutlet weak var lbl_description:UILabel!
	//MARK: - Variables
	var interactor: GamesInteractionLogic?
	var router: GamesRoutingLogic?
	var currentMode = Filtering.normal
	var gameID : Int?
	var gameItem : GameItem!
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after sloading the view.
		doAnyAdditionalSetup()
	}
	func doAnyAdditionalSetup()
	{
		setup()
		guard gameID != nil  else {
			print("Game id is nil!")
			return
		}
		interactor?.fetchGameDetails(gameID: gameID!)
	}

	private func setup() {
		let viewController = self
		let interactor = GamesInteractor()
		let presenter = GamesPresenter()
		let router = GamesRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		interactor.fetcher = GamesFetcher()
		presenter.logicDisplayer = viewController
		router.gameDetailsViewController = viewController
	}
	@IBAction func actionOfbtnVisitWebsite(sender:Any)
	{
		guard let url = URL(string: gameItem.website ?? "")
		else{
			return
		}
		openSafariWithLink(url: url)
	}
	@IBAction func actionOfbtnVisitReddit(sender:Any)
	{
		guard let url = URL(string: gameItem?.reddit_url ?? "")
		else{
			return
		}
		openSafariWithLink(url: url)
	}
	@IBAction func actionOfbtnFavourite(sender:Any)
	{
		if Storage.fileExists(Constants.FavouriteGames, in: .documents){
		  var	arrayOfGames = Storage.retrieve(Constants.FavouriteGames , from: .documents, as: [GameItem].self)
			if arrayOfGames.contains(where: { $0.id == gameID }) {
				 // found
				arrayOfGames.remove(at: arrayOfGames.firstIndex(where: { $0.id == gameItem.id })!)
				Storage.store(arrayOfGames , to: .documents, as: Constants.FavouriteGames)
				btn_Favourite.setTitle("Favourite", for: .normal)

			} else {
				 // not
				arrayOfGames.append(gameItem)
				Storage.store(arrayOfGames , to: .documents, as: Constants.FavouriteGames)
				btn_Favourite.setTitle("UnFavourite", for: .normal)
			}
		}
		else
		{
			let arrayOfGames = [gameItem]
			Storage.store(arrayOfGames , to: .documents, as: Constants.FavouriteGames)
			btn_Favourite.setTitle("UnFavourite", for: .normal)
		}

	}
	@IBAction func actionOfbtnBack(sender:Any)
	{
		self.navigationController?.popViewController(animated: true)
	}
	func openSafariWithLink(url:URL)
	{
		let config = SFSafariViewController.Configuration()
		config.entersReaderIfAvailable = true

		let vc = SFSafariViewController(url: url, configuration: config)
		present(vc, animated: true)
	}
}

extension GameDetailsViewController:GamesDisplayLogic
{
	func presentGameDetails(result: GameItem) {
		lbl_name.text = result.name
		lbl_description.text = result.description
		gameItem = result
		if let url = URL(string: result.background_image ?? "")
		{
			imgV_backgroundImage.kf.setImage(with: url)
		}
		checkIfFavourited()
	}
	
	func displayFetchedResults(results: [GameItem], prev: String?, next: String?) {
		//
	}
	func displaySearchResults(results: [GameItem], prev: String?, next: String?) {
		//
	}
}

extension GameDetailsViewController{
	open class func nibName() -> String {
			  return String(describing:   GameDetailsViewController.self)
	}
}
extension GameDetailsViewController
{
	func checkIfFavourited()
	{
		if Storage.fileExists(Constants.FavouriteGames, in: .documents){
			let	arrayOfGames = Storage.retrieve(Constants.FavouriteGames , from: .documents, as: [GameItem].self)
			if arrayOfGames.contains(where: { $0.id == gameID }) {
				 // found
				btn_Favourite.setTitle("UnFavourite", for: .normal)
			} else {
				 // not
				btn_Favourite.setTitle("Favourite", for: .normal)
			}
		}
		else
		{
			btn_Favourite.setTitle("Favourite", for: .normal)
		}
	}
}
