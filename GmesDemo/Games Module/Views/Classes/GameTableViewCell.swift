//
//  GameTableViewCell.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/15/21.
//

import UIKit
import Kingfisher
class GameTableViewCell: UITableViewCell {

	//MARK: - Outlets
	@IBOutlet weak var imgV_backgroundImage: UIImageView!
	@IBOutlet weak var lbl_gameName: UILabel!
	@IBOutlet weak var lbl_metratics: UILabel!
	@IBOutlet weak var lbl_rating: UILabel!
	@IBOutlet weak var lbl_geners: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	func refreshWithGameItem(item:GameItem)
	{
		lbl_gameName.text = item.name ?? "Name not Found"
		lbl_geners.text = item.genres ?? "Genres not Found"
		lbl_metratics.text = "\( item.metacritic ?? 0)"
		if let url = URL(string: item.background_image ?? "")
		{
			imgV_backgroundImage.kf.setImage(with: url)
		}
	}
	open class func identifier() -> String {
			  return String(describing:   GameTableViewCell.self)
	}
    
}
