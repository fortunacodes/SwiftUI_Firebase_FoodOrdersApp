//
//  ContentView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 25/05/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase
import SDWebImageSwiftUI

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    
    var body: some View {
        
        Home()
        
    }
    
    func getOut(){
        
    }
}

struct Loader : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .blue
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Homdos : View {
    
    @ObservedObject var categories = getCategoriesData()
    
    var body : some View{
        VStack{
            List(categories.datas){
                i in
                Text(i.name)
            }
        }
    }
}

class getCategoriesData : ObservableObject{
    @Published var datas = [category]()
    
    init (){
        let db = Firestore.firestore()
        
        db.collection("categories").addSnapshotListener{
            (snap,err) in
            
            if (err != nil){
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let pic = i.document.get("pic") as! String
                self.datas.append(category(id: id, name: name, pic: pic))
            }
        }
        
    }
}

struct category : Identifiable{
    var id : String
    var name : String
    var pic : String
}



let screen = UIScreen.main.bounds // Recupera el tamño del dispositivo
