//
//  KisiGuncelleViewController.swift
//  Contacts-App With CoreData
//
//  Created by Ömer Faruk Kılıçaslan on 18.04.2022.
//

import UIKit

class KisiGuncelleViewController: UIViewController {

    @IBOutlet weak var kisiAdTextField: UITextField!
    @IBOutlet weak var kisiTelTextField: UITextField!
    var kisi:Kisiler?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let k = kisi {
            kisiAdTextField.text = k.kisi_ad
            kisiTelTextField.text = k.kisi_tel
        }
    }
    
    @IBAction func guncelle(_ sender: Any) {
        
        if let k = kisi, let ad = kisiAdTextField.text, let tel = kisiTelTextField.text {
            
            Kisilerdao().kisiGuncelle(kisi_id: k.kisi_id!, kisi_ad: ad, kisi_tel: tel)
        }
        self.navigationController?.popToRootViewController(animated: true)
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
