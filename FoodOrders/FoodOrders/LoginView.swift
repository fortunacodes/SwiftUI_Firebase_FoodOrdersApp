//
//  LoginView.swift
//  FoodOrders
//
//  Created by Jesús  Fortuna on 06/06/2020.
//  Copyright © 2020 Jesús  Fortuna. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase
struct LoginView: View {
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @Binding var showProfileDetails : Bool

    var body: some View {
        VStack{
            Text("as")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Login( show: .constant(false))
    }
}

struct Login: View{
    @State var color = Color.black.opacity(0.2)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        ZStack {
            ZStack (alignment: .topTrailing)  {
                GeometryReader {_ in
                    VStack {
                        Text("Hola, de nuevo!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.email != "" ? Color(#colorLiteral(red: 0.6862745098, green: 0.06666666667, blue: 0.06666666667, alpha: 1)).opacity(0.3) : self.color, lineWidth: 0.5)
                                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                                    .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                        )
                            .padding(.top, 25)
                        
                        HStack (spacing: 15) {
                            VStack{
                                
                                if self.visible{
                                    TextField("Contraseña", text: self.$pass)
                                        .autocapitalization(.none)
                                }else{
                                    SecureField("Contraseña", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                self.visible.toggle()
                            }){
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(self.email != "" ? Color(#colorLiteral(red: 0.6862745098, green: 0.06666666667, blue: 0.06666666667, alpha: 1)).opacity(0.3) : self.color, lineWidth: 0.5)
                                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                                .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                            
                        )
                            .padding(.top, 25)
                        
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                self.resetPass()
                            }){
                                Text("Contraseña olvidada")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                            }
                        }
                        
                        Button(action: {
                            self.verifys()
                        }){
                            Text("Iniciar")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .frame(width: screen.width - 50)
                        }
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6862745098, green: 0.06666666667, blue: 0.06666666667, alpha: 1)).opacity(0.4), Color.black.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
                        )
                            
                            .cornerRadius(10)
                            .padding(.top, 25)
                            .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                            .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                        
                    }
                    .padding(.horizontal, 25)
                }
                
                Button(action: {
                    self.show.toggle()
                }){
                    Text("Registrarme")
                        .fontWeight(.bold)
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                }
                    
                .padding()
                
            }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
            
            
        }
    }
    func verifys(){
        if self.email != "" && self.pass != ""{
            Auth.auth().signIn(withEmail: self.email, password: self.pass){
                (res,err) in
                
                if err != nil{
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                print("succes")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                
            }
        }
        else{
            self.error = "Por favor, rellena todos los campos"
            self.alert.toggle()
        }
    }
    
    func resetPass(){
        
        if self.email != "" {
            Auth.auth().sendPasswordReset(withEmail: self.email){
                (err) in
                
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
            }
        }
        else{
            self.error = "El campo email está vacío"
            self.alert.toggle()
        }
        
    }
}

struct SignUp : View{
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        ZStack{
            ZStack (alignment: .topLeading)  {
                GeometryReader {_ in
                    VStack {
                        Text("Estás cerca.")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                .stroke(self.email != "" ? Color(#colorLiteral(red: 0.6862745098, green: 0.06666666667, blue: 0.06666666667, alpha: 1)).opacity(0.3) : self.color, lineWidth: 0.5)
                                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                                .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                        )
                            .padding(.top, 25)
                        
                        HStack (spacing: 15) {
                            VStack{
                                
                                if self.visible{
                                    TextField("Contraseña", text: self.$pass)
                                        .autocapitalization(.none)
                                }else{
                                    SecureField("Contraseña", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                self.visible.toggle()
                            }){
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                             .stroke(self.pass != "" ? Color(#colorLiteral(red: 0.6862745098, green: 0.06666666667, blue: 0.06666666667, alpha: 1)).opacity(0.3) : self.color, lineWidth: 0.5)
                             .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                             .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                             .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                            
                        )
                            .padding(.top, 25)
                        
                        
                        HStack (spacing: 15) {
                            VStack{
                                
                                if self.revisible{
                                    TextField("Repite contraseña", text: self.$repass)
                                        .autocapitalization(.none)
                                    
                                }else{
                                    SecureField("Repite contraseña", text: self.$repass)
                                        .autocapitalization(.none)                                    
                                }
                            }
                            
                            Button(action: {
                                self.revisible.toggle()
                            }){
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                             .stroke(self.repass != "" ? Color(#colorLiteral(red: 0.6862745098, green: 0.06666666667, blue: 0.06666666667, alpha: 1)).opacity(0.3) : self.color, lineWidth: 0.5)
                             .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                             .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                             .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                            
                        )
                            .padding(.top, 25)
                        
                        
                        Button(action: {
                            self.registerUser()
                        }){
                            Text("Registrame")
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .frame(width: screen.width - 50)
                        }
                        .background(
                                       LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6862745098, green: 0.06666666667, blue: 0.06666666667, alpha: 1)).opacity(0.4), Color.black.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
                                   )
                                       
                                       .cornerRadius(10)
                                       .padding(.top, 25)
                                       .shadow(color: Color("shadow1"), radius: 5, x: -5, y: -5)
                                       .shadow(color: Color("shadow2"), radius: 5, x: 5, y: 5)
                        
                    }
                    .padding(.horizontal, 25)
                }
                
                Button(action: {
                    self.show.toggle()
                }){
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                }
                .padding()
                
            }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    func registerUser(){
        if self.email != "" {
            if self.pass == self.repass{
                Auth.auth().createUser(withEmail: self.email, password: self.pass){
                    (res, err) in
                    
                    if err != nil{
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    let userID = Auth.auth().currentUser!.uid
                    print("success" + userID)

                    let db = Firestore.firestore()
                             
                             db.collection("users")
                                 .document(userID)
                                 .setData(
                                     
                                     [
                                        "name" : "",
                                        "street" : "",
                                        "door" : "",
                                        "mov1" : "",
                                        "mov2" : "",
                                        "noteRestaurant" : "",
                                        "noteRider" : "",
                                        "email" : self.email,
                                        "userID" : userID
                                        
                                     ]
                                     
                                     )
                                 {
                                     (err) in
                                     if err != nil{
                                         print((err?.localizedDescription)!)
                                         return
                                     }
                             }
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }
            }
            else{
                self.error = "Las contraseñas no coinciden"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Por favor rellena los campos"
            self.alert.toggle()
        }
    }
}



