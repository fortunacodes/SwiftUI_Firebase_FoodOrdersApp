//
//  SwiftUIView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 06/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import Firebase

struct product : Identifiable{
    var id : String
    var name : String
    var pic: String
    var price: Double
    var codestore: String
    var description: String

    var ingredients: [String]
    
}


class getProductsStore : ObservableObject{
    @Published var datas = [product]()
    
    
    init (){
        let db = Firestore.firestore()
        db.collection("productos").addSnapshotListener{
            
            (snap,err) in
            
            if (err != nil){
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let pic = i.document.get("pic") as? String
                let price = i.document.get("price") as? Double
                let codestore = i.document.get("codestore") as? String
                let description = i.document.get("description") as? String

                let ingredients = i.document.get("codestore") as? [String]
                
                
                self.datas.append(product(id: id, name: name, pic: pic ?? "", price:  price ?? 0, codestore: codestore ?? "", description: description ?? "", ingredients: ingredients ?? [""]))
                
            }
        }
    }
}
