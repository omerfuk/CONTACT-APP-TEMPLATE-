//
//  KisiHucreTableViewCell.swift
//  Contacts-App With CoreData
//
//  Created by Ömer Faruk Kılıçaslan on 18.04.2022.
//

import UIKit

class KisiHucreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var kisiYaziLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
