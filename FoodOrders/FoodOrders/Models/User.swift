//
//  User.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 11/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//


import SwiftUI
import Firebase
import FirebaseAuth


struct userData : Identifiable{
    var id : String
    var name: String
    var street: String
    var door : String
    var mov1 : String
    var mov2 : String
    var noteRest : String
    var noteRider : String
    var email : String
    var userID : String
}

struct riderData : Identifiable{
    var id : String
    var name: String
    var adress : String
    var mov1 : String
    var rating : String
    var riderID : String
    var lastOrder : String
    var available : Bool
}


class getUserData : ObservableObject{
    @Published var datas = [userData]()
    @ObservedObject var user = getActiveUser()
    @Published var userDataAlone : userData!

    init (){
        let db = Firestore.firestore()
        
        self.userDataAlone = nil
        db.collection("users").whereField("userID", isEqualTo: self.user.activeUserID)
        .getDocuments(){
            (snap,err) in
            
            if err != nil{
                print ((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let name = i.get("name") as? String
                let street = i.get("street") as? String
                let door = i.get("door") as? String
                let mov1 = i.get("mov1") as? String
                let mov2 = i.get("mov2") as? String
                let noteRest = i.get("note") as? String
                let noteRider = i.get("noteRider") as? String
                let email = i.get("email") as? String
                let userID = i.get("userID") as? String

                self.datas.append( userData(id: id, name: name ?? "", street: street ?? "", door: door ?? "", mov1: mov1 ?? "", mov2: mov2 ?? "", noteRest: noteRest ?? "", noteRider: noteRider ?? "", email: email ?? "", userID: userID ?? "" )  )
                
                self.userDataAlone = userData(id: id, name: name ?? "", street: street ?? "", door: door ?? "", mov1: mov1 ?? "", mov2: mov2 ?? "", noteRest: noteRest ?? "",
                    noteRider: noteRider ?? "" ,email: email ?? "", userID: userID ?? "")
            }
        }
    }
}


class getActiveUser : ObservableObject{
    @Published var activeUserID : String
    init (){
        self.activeUserID = ""
        if Auth.auth().currentUser != nil{
            self.activeUserID = Auth.auth().currentUser!.uid
        }
    }
}

class getRiderAvailable : ObservableObject{
    @Published var riderAvailable : riderData?

    init (){
        let db = Firestore.firestore()
        
        db.collection("riders")
            .whereField("riderAvailable", isEqualTo: true)
            .order(by: "rating")
            .order(by: "lastOrder", descending: true)
            .limit(to: 1)
            .getDocuments(){
            (snap,err) in
            
            if err != nil{
                print ((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                let id = i.documentID
                let name = i.get("name") as? String
                let adress = i.get("adress") as? String
                let mov1 = i.get("mov1") as? String
                let rating = i.get("rating") as? String
                let riderID = i.get("riderID") as? String
                let lastOrder = i.get("lastOrder") as? String
                let available = i.get("available") as? Bool
                
                
                self.riderAvailable = riderData(id: id, name: name ?? "", adress: adress ?? "", mov1: mov1 ?? "", rating: rating ?? "", riderID: riderID ?? "", lastOrder: lastOrder ?? "", available: available ?? false)
            }
        }
    }
}


struct User_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
