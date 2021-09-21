import UIKit
protocol GamesDisplayLogic: AnyObject {
	func displayFetchedResults(results:[GameItem],prev:String?,next:String?)
	func displaySearchResults(results:[GameItem],prev:String?,next:String?)
	func presentGameDetails(result:GameItem)
}
class GamesListViewController: UIViewController {

	//MARK: - Outlets
	@IBOutlet weak var tableView_Games:UITableView!
	@IBOutlet weak var tfSearch: UITextField!
	@IBOutlet weak var viewSearch: DesignableUIView!
	@IBOutlet weak var btnSearch: UIButton!
	//MARK: - Variables
	var interactor: GamesInteractionLogic?
	var router: GamesRoutingLogic?
	var arrayOfGames = [GameItem]()
	var arrayOfGames_filtered = [GameItem]()
	var currentMode = Filtering.normal
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after sloading the view.
		doAnyAdditionalSetup()
	}
	func doAnyAdditionalSetup()
	{
		setup()
		registerNibFiles()
		tfSearch.addTarget(self, action: #selector(GamesListViewController.textFieldDidChange(_:)), for: .editingChanged)
		fetchAndKeepState()
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
		router.gamesListViewController = viewController
	}
	func registerNibFiles()
	{
		tableView_Games.register(UINib(nibName: GameTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: GameTableViewCell.identifier())
	}
	@objc func textFieldDidChange(_ textField: UITextField) {
		currentMode = textField.text!.count > 3 ? .filter : .normal
		if currentMode == .filter
		{
			interactor?.fetchSearchResults(key: textField.text!, index: 1)
		}
	}
}

extension GamesListViewController:GamesDisplayLogic
{
	func presentGameDetails(result: GameItem) {
		//
	}

	func displayFetchedResults(results: [GameItem], prev: String?, next: String?) {
		print("results=\(results)\n prev=\(String(describing: prev))\n next=\(String(describing: next))")
		arrayOfGames = results
		tableView_Games.reloadData()
	}
	func displaySearchResults(results: [GameItem], prev: String?, next: String?) {
		print("results=\(results)\n prev=\(String(describing: prev))\n next=\(String(describing: next))")
		arrayOfGames_filtered = results
		tableView_Games.reloadData()
	}
}
extension GamesListViewController: UITableViewDelegate,UITableViewDataSource
{
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier()) as! GameTableViewCell
		let gameItem = currentMode == .filter ? arrayOfGames_filtered[indexPath.row] : arrayOfGames[indexPath.row]
		cell.refreshWithGameItem(item: gameItem)
		cell.selectionStyle = .none
	   return cell
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currentMode == .filter ? arrayOfGames_filtered.count : arrayOfGames.count
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let gameItem = currentMode == .filter ? arrayOfGames_filtered[indexPath.row] : arrayOfGames[indexPath.row]
		router?.routeToDetailsPage(gameID:gameItem.id!)
	}
}
extension GamesListViewController{
	open class func nibName() -> String {
			  return String(describing:   GamesListViewController.self)
	}
}
enum Filtering {
	case filter
	case normal
}
extension GamesListViewController{
	func fetchAndKeepState()
	{
		addPrefetchFeature()
	}
	func addPrefetchFeature(){
		// here we check either to go offline or online based on if data fetched once before
		if !HelpingMethods.isConnectedToNetwork() && Storage.fileExists(Constants.GamesOffline, in: .documents){
			arrayOfGames = Storage.retrieve(Constants.GamesOffline , from: .documents, as: [GameItem].self)
			tableView_Games.reloadData()

		}
		else
		{
			interactor?.fetchGamesList(index: 1)


		}
	}
}
