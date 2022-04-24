//
//  KisiEkleViewController.swift
//  Contacts-App With CoreData
//
//  Created by Ömer Faruk Kılıçaslan on 18.04.2022.
//

import UIKit

class KisiEkleViewController: UIViewController {

    @IBOutlet weak var kisiAdTextField: UITextField!
    @IBOutlet weak var kisiTelTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ekle(_ sender: Any) {
        if let ad = kisiAdTextField.text,let tel = kisiTelTextField.text {
            
            Kisilerdao().kisiEkle(kisi_ad: ad, kisi_tel: tel)
            self.navigationController?.popToRootViewController(animated: true)
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
