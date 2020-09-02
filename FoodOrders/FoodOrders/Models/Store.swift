//
//  Store.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 06/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import Firebase

struct store : Identifiable{
    var id : String
    var name : String
    var category : String
    var stars : String
    var timepreparation: String
    var pic: String
    var direction : String
    var googledirection : String
    var product_type : String
    var codeStore : String
    var phone : String


}


class getStoreData : ObservableObject{
    @Published var datas = [store]()
    
    init (){
        let db = Firestore.firestore()
        
        db.collection("restaurants").addSnapshotListener{
            (snap,err) in
            
            if (err != nil){
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let category = i.document.get("category") as? String
                let stars = i.document.get("stars") as? String
                let timepreparation = i.document.get("timepreparation") as? String
                let pic = i.document.get("pic") as? String
                let direction = i.document.get("direction") as? String
                let googledirection = i.document.get("googledirection") as? String
                let product_type = i.document.get("product_type") as? String
                let codeStore = i.document.get("codeStore") as? String
                let phone = i.document.get("phone") as? String

                
                self.datas.append(store(id: id, name: name, category: category ?? "", stars: stars ?? "", timepreparation: timepreparation ?? "", pic : pic ?? "",direction: direction ?? "", googledirection:  googledirection ?? "", product_type: product_type ?? "", codeStore: codeStore ?? "", phone: phone ?? "" ))
                
            }
        }
    }
}


class getStoreDataAlone : ObservableObject{
    @ObservedObject var cartData = getCartData()
    @Published var storeDataAlone : store!

    init (){
        let db = Firestore.firestore()
        print("codigoStore1 \(String(describing: self.cartData.codStore))")

        db.collection("restaurants").whereField("codeStore", isEqualTo: "O5HypxuXI3w43QX33udE")
        .getDocuments(){
            (snap,err) in
            
            if (err != nil){
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let category = i.document.get("category") as? String
                let stars = i.document.get("stars") as? String
                let timepreparation = i.document.get("timepreparation") as? String
                let pic = i.document.get("pic") as? String
                let direction = i.document.get("direction") as? String
                let googledirection = i.document.get("googledirection") as? String
                let product_type = i.document.get("product_type") as? String
                let codeStore = i.document.get("codeStore") as? String
                let phone = i.document.get("phone") as? String

                self.storeDataAlone = store(id: id, name: name, category: category ?? "", stars: stars ?? "", timepreparation: timepreparation ?? "", pic : pic ?? "",direction: direction ?? "", googledirection:  googledirection ?? "", product_type: product_type ?? "", codeStore: codeStore ?? "", phone: phone ?? "" )
                
            }
        }
    }
}
