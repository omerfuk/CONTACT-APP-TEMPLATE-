//
//  ViewController.swift
//  Contacts-App With CoreData
//
//  Created by Ömer Faruk Kılıçaslan on 18.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kisilerTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var kisilerListe = [Kisiler]()
    
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veriTabaniKopyala()
        

        
        
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        searchBar.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if aramaYapiliyorMu == true {
            kisilerListe = Kisilerdao().aramaYap(kisi_ad: aramaKelimesi!)
        }
        else{
            kisilerListe = Kisilerdao().tumKisilerAl()
        }
        
        
        
        kisilerTableView.reloadData()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        
        if segue.identifier == "toDetay" {
            
            let gidilecekVC = segue.destination as! KisiDetayViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
        if segue.identifier == "toGuncelle" {
            let gidilecekVC = segue.destination as! KisiGuncelleViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
    }
    
    func veriTabaniKopyala(){
            
            let bundleYolu = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
            
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let fileManager = FileManager.default
            
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
            
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veri Tabanı zaten var, kopyalamaya gerek yok.")
            }
            else{
                do {
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                    
                } catch  {
                    print(error)
                }
            }
            
            
        }

}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! KisiHucreTableViewCell
        
        cell.kisiYaziLabel.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        
        return cell
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
        
        
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let silAction = UITableViewRowAction(style: .default, title: "Sil", handler: { (action:UITableViewRowAction,indexPath:IndexPath) -> Void in
//
//            print("Sil Tıklandı : \(self.liste[indexPath.row])")
//
//
//        })
//
//        let guncelleAction = UITableViewRowAction(style: .normal, title: "Guncelle", handler: { (action:UITableViewRowAction,indexPath:IndexPath) -> Void in
//
//            print("Güncelle Tıklandı : \(self.liste[indexPath.row])")
//
//            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
//
//
//        })
//
//        return [silAction,guncelleAction]
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, boolValue) in
            
            let kisi = self.kisilerListe[indexPath.row]
            
            Kisilerdao().kisiSil(kisi_id: kisi.kisi_id!)
            
            if self.aramaYapiliyorMu == true {
                self.kisilerListe = Kisilerdao().aramaYap(kisi_ad: self.aramaKelimesi!)
            }
            else{
                self.kisilerListe = Kisilerdao().tumKisilerAl()
            }
            
            self.kisilerTableView.reloadData()

            
        }
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle") { (contextualAction,view,boolValue) in
            
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        
        }
        return UISwipeActionsConfiguration(actions: [silAction,guncelleAction])
    }
}

extension ViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        aramaKelimesi = searchText
        
        if searchText == "" {
            aramaYapiliyorMu = false
        }
        else {
            aramaYapiliyorMu = true
        }
        
        kisilerListe = Kisilerdao().aramaYap(kisi_ad: aramaKelimesi!)
        print("Arama Sonuç : \(searchText)")
        kisilerTableView.reloadData()
    }
}
