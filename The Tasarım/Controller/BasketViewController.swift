//
//  BasketViewController.swift
//  The Tasarım
//
//  Created by Şeyda Soylu on 11.12.2022.
//

import UIKit

class BasketViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource , UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    let defaults = UserDefaults.standard
    @IBOutlet var firstView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var topSecondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.array(forKey: "basket") as? [Int] {
            selam.basketArray = item
        }
        if selam.basketArray == [99999] || selam.basketArray == []  {
            topSecondView.isHidden = true
        }else {
            topView.isHidden = true
        }
        myNewContentArray = []
        basket = []
        getlike()
        getbasket()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BasketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BasketReusableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BasketTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        print("asa\(selam.basketArray)")
        
    }
    func getlike() {
        for number in selam.basketArray {
            for mynumber in View {
                if number == mynumber.number {
                    basket.append(mynumber)
                    print(mynumber)
                }
            }
        }
    }
    func getbasket() {
        for number in selam.likeArray {
            for mynumber in View {
                if number == mynumber.number {
                    myNewContentArray.append(mynumber)
                    print(mynumber)
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myNewContentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasketReusableCell", for: indexPath as IndexPath) as! BasketCollectionViewCell
        URLSession.shared.dataTask(with: URL(string: myNewContentArray[indexPath.item].image)!) { (data, response, error) in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: imageData)
            }
        }.resume()
        cell.label.text = myNewContentArray[indexPath.item].label
        return cell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell" , for: indexPath) as! BasketTableViewCell
        URLSession.shared.dataTask(with: URL(string: basket[indexPath.item].image)!) { (data, response, error) in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                cell.imageview.image = UIImage(data: imageData)
            }
        }.resume()
        cell.priceLabel.text = "\(basket[indexPath.item].price) TL"
        cell.label.text = basket[indexPath.item].label

        cell.plusButton.addTarget(self, action: #selector(plusButton(sender:)), for: .touchUpInside)
        cell.plusButton.tag = indexPath.row
        cell.trashButton.addTarget(self, action: #selector(trashButton(sender:)), for: .touchUpInside)
        cell.trashButton.tag = indexPath.row
        
        let index = indexPath.item
       
        cell.numberOfProduct.text = "\(selam.productNumber["\(basket[indexPath.item].number)"]!)"
        print("xxx\(selam.productNumber["\(basket[indexPath.item].number)"]!)")
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    @objc func plusButton(sender: UIButton){
        let buttonTag = sender.tag
      

        tableView.reloadData()
    }
    @objc func trashButton(sender: UIButton){
        let buttonTag = sender.tag
        print("sss\(buttonTag)")
    }
}
