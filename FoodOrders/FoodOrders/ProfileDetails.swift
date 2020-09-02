//
//  ProfileDetails.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 11/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct ProfileDetails: View {
    @State var name : String
    @Binding var street : String
    @State var door : String
    @Binding var mov1 : String
    @State var mov2 : String
    @State var noteRest : String
    @State var noteRider : String
    @ObservedObject var activeUser = getActiveUser()
    @Binding var showProfileDetails : Bool
    
    var body: some View {
        ZStack  {
            VStack (alignment: .center) {
                ScrollView{
                //Direccion
                VStack {
                    HStack {
                        Text("Dirección")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .shadow(radius: 3)
                        
                        Spacer()
                    }
                    
                    
                    HStack {
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: 100, height: 4)
                            .cornerRadius(8)
                            .offset(y: -5)
                        
                        Spacer()
                    }
                    
                    VStack  {
                        TextField("Calle", text: self.$street)
                            .padding()
                        
                        
                        TextField("Puerta/Apto", text: self.$door)
                            .padding()
                    }
                    
                }
                //Contacto
                VStack {
                    HStack {
                        Text("Contacto")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .shadow(radius: 3)
                        
                        Spacer()
                    }
                    
                    
                    HStack {
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: 100, height: 4)
                            .cornerRadius(8)
                            .offset(y: -5)
                        
                        Spacer()
                    }
                    
                    VStack  {
                        TextField("Movil 1", text: self.$mov1)
                            .keyboardType(.numberPad)
                            .padding()
                        
                        
                        TextField("Movil 2 (Opcional)", text: self.$mov2)
                            .keyboardType(.numberPad)
                            .padding()
                    }
                    
                }
                //Nota para el rest
                VStack {
                    HStack {
                        Text("Nota para el restaurante")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .shadow(radius: 3)
                        
                        Spacer()
                    }
                    
                    
                    HStack {
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: 100, height: 4)
                            .cornerRadius(8)
                            .offset(y: -5)
                        
                        Spacer()
                    }
                    
                    VStack  {
                        TextField("Ej: Poner la salsa aparte", text: self.$noteRest)
                            .padding()
                        
                    }
                    
                }
                //Nota para el repartidor
                VStack {
                    HStack {
                        Text("Nota para el repartidor")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .shadow(radius: 3)
                        
                        Spacer()
                    }
                    
                    
                    HStack {
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: 100, height: 4)
                            .cornerRadius(8)
                            .offset(y: -5)
                        
                        Spacer()
                    }
                    
                    VStack  {
                        TextField("Ej: Es la casa amarilla", text: self.$noteRider)
                            .autocapitalization(.none)
                            .padding()
                        
                    }
                    
                }
                }

                    
                HStack (alignment: .center, spacing: 30){
                    
                    
                    ZStack{
                        NeumorphismRectangle(width: screen.width/2 + 100, height: 40)
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1),Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                            .frame(width: screen.width/2 + 100, height: 40)
                        
                        HStack{
                            Text("GUARDAR")
                            Image(systemName: "square.and.arrow.down.fill")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .shadow(radius: 7)

                    }
                    .onTapGesture {
                        let db = Firestore.firestore()
                        print(self.mov1)
                        db.collection("users")
                            .document(self.activeUser.activeUserID)
                            .updateData(
                                
                                [
                                    "street" : self.street,
                                    "door" : self.door,
                                    "mov1" : self.mov1,
                                    "mov2" : self.mov2,
                                    "noteRestaurant" : self.noteRest,
                                    "noteRider" : self.noteRider
                                    
                                ]
                                
                                )
                            {
                                (err) in
                                if err != nil{
                                    print((err?.localizedDescription)!)
                                    return
                                }
                        }
                        
                        self.showProfileDetails.toggle()
                    }
                }
            }
        }
    }
}

struct ProfileDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetails(name: "asd", street: .constant("0..."), door: "", mov1: .constant("031 ..."), mov2: "", noteRest: "", noteRider: "", showProfileDetails: .constant(false))
    }
}
