//
//  FrotaTableViewCell.swift
//  ScaniaAssist
//
//  Created by Caio Thomaz Nogueira  on 17/10/22.
//

import UIKit

class FrotaTableViewCell: UITableViewCell {

    @IBOutlet weak var lbSerie: UILabel!
    @IBOutlet weak var lbAno: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
