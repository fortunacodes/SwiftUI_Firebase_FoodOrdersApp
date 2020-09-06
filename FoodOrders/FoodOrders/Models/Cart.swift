//
//  Cart.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 06/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct itemCart : Identifiable{
    var id : String
    var name : String
    var pic : String
    var codeStore : String
    var quantity : NSNumber
    var price : NSNumber
    var itemID : String
    var userID : String
    
    
}

class getCartData : ObservableObject{
    @Published var datas = [itemCart]()
    @ObservedObject var user = getActiveUser()
    @Published var sum : Double
    @Published var codStore : String
    @Published var cartList : [String]
    @Published var thereareItems : Bool
    
    init (){
        let db = Firestore.firestore()
        self.sum = 0
        self.codStore = ""
        self.cartList = []
        self.thereareItems = false
        db.collection("cart").whereField("userID", isEqualTo: self.user.activeUserID)
            .getDocuments(){
                (snap,err) in
                
                if err != nil{
                    print ((err?.localizedDescription)!)
                    return
                }
                
                for i in snap!.documents{
                    
                    let id = i.documentID
                    let name = i.get("item") as? String
                    let pic = i.get("pic") as? String
                    let codeStore = i.get("codeStore") as? String
                    let quantity = i.get("quantity") as? NSNumber
                    let price = i.get("price") as? NSNumber
                    let itemID = i.get("itemID") as? String
                    let userID = i.get("userID") as? String
                    
                    self.datas.append(  itemCart(id: id, name : name ?? "", pic : pic ?? "", codeStore: codeStore ?? "", quantity: quantity ?? 0, price: price ?? 0, itemID:  itemID ?? "", userID: userID ?? ""))
                    
                    self.sum += Double(truncating: price!)
                    self.codStore = codeStore!
                    self.cartList.append(" \(quantity?.stringValue ?? "") | \(name ?? "")  ")
                    for element in self.cartList {
                        print("array\(element)")
                    }
                }
        }
        if datas.count != 0{
            thereareItems = true
        }
    }
}

func deleteCartData( activeUserID : String ){
    let db = Firestore.firestore()

    db.collection("cart")
        .whereField("userID", isEqualTo: activeUserID)
        .getDocuments(){
            (snap,err) in
            
            if err != nil{
                print ((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
                db.collection("cart")
                    .document(i.documentID)
                    .delete{
                        (err) in
                        
                        if err != nil{
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                }
            }
    }
//    self.cartData.cartList.removeAll()
}



