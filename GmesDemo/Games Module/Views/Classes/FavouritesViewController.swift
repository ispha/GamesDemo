//
//  FavouritesViewController.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/19/21.
//

import UIKit

class FavouritesViewController: UIViewController {

	//MARK: - Outletes
	@IBOutlet weak var tableView_Favourites:UITableView!
	//MARK: - Variables
	var arrayOfFavourites = [GameItem]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		doanyAdditionalSetup()
    }
	func doanyAdditionalSetup()
	{
       registerNibFiles()
	}
	func registerNibFiles()
	{
		tableView_Favourites.register(UINib(nibName: GameTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: GameTableViewCell.identifier())
	}
	override func viewWillAppear(_ animated: Bool) {
		fetchFavouritedGames()
	}
	func fetchFavouritedGames()
	{
		if Storage.fileExists(Constants.FavouriteGames, in: .documents){
			arrayOfFavourites = Storage.retrieve(Constants.FavouriteGames , from: .documents, as: [GameItem].self)
			self.tableView_Favourites.reloadData()
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FavouritesViewController : UITableViewDelegate,UITableViewDataSource
{
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier()) as! GameTableViewCell
		return cell
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return HelpingMethods.emptyTableView(tableView: tableView, dataCount: arrayOfFavourites.count, dataCome: true, emptyTableViewMessage: "No Favs Yet!")
	}
}
extension FavouritesViewController{
	open class func nibName() -> String {
			  return String(describing:   FavouritesViewController.self)
	}
}
