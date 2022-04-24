//
//  KisiDetayViewController.swift
//  Contacts-App With CoreData
//
//  Created by Ömer Faruk Kılıçaslan on 18.04.2022.
//

import UIKit

class KisiDetayViewController: UIViewController {

    @IBOutlet weak var kisiTelLabel: UILabel!
    @IBOutlet weak var kisiAdLabel: UILabel!
    
    var kisi:Kisiler?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let k = kisi{
            kisiAdLabel.text = k.kisi_ad
            kisiTelLabel.text = k.kisi_tel
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
