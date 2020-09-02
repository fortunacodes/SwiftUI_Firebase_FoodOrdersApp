//
//  ProductsView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 30/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//


import SwiftUI
import Firebase
import SDWebImageSwiftUI


struct ProductsView: View {
    var product = getProductsStore()
    
    var body: some View {
        VStack{
//            Text("YAUIsdhas")
            if self.product.datas.count != 0 {
                
                ForEach (self.product.datas) {
                    i in
                    Text(i.name)
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}


class getProductsStore : ObservableObject{
    @Published var datas = [product]()
    //    var codeStore : String = ""/
    
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
                let price = i.document.get("price") as? String
                
                
                self.datas.append(product(id: id, name: name, pic: pic ?? "", price:  price ?? ""))
                
            }
        }
    }
}


struct product : Identifiable{
    var id : String
    var name : String
    var pic: String
    var price: String
}

