//
//  BookCell.swift
//  HackerBook
//
//  Created by Vicente de Miguel on 13/12/15.
//  Copyright © 2015 Nicatec Software. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var portada: UIImageView!

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titulo.textColor = UIColor.defaultColorHacker()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
