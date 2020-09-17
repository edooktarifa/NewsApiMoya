//
//  NewsCellTableViewCell.swift
//  NewsApiWithMoya
//
//  Created by Lawencon on 02/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import UIKit

class NewsCellTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var newsImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
