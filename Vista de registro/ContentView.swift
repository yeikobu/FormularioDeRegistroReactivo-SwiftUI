//
//  ContentView.swift
//  Vista de registro
//
//  Created by Jacob Aguilar on 14-02-21.
//

import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject private var registrationVM = RegistrationViewModel()
    
    var body: some View {
        
        VStack {
            
            Spacer(minLength: 0)
            
            Text("Registrar nueva cuenta")
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .padding(.horizontal, 35)
                .padding(.vertical)
            
            VStack{
                
                //Campo nombre de usuario
                SingleFormView(fieldValue: $registrationVM.userName, fieldName: "Nombre de usuario", isProtected: false)
                ValidationFormView(iconName: registrationVM.userNameLengthValid ? "checkmark.circle" : "xmark.circle", iconColor: registrationVM.userNameLengthValid ? Color.green : Color.red, formText: "Mínimo 6 carácteres", conditionChecked: registrationVM.userNameLengthValid)
                    .padding(.top, 0)
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                
                
                //Campo contraseña
                SingleFormView(fieldValue: $registrationVM.password, fieldName: "Contraseña", isProtected: true)
                VStack {
                    ValidationFormView(iconName: registrationVM.passwordLengthValid ? "checkmark.circle" : "xmark.circle", iconColor: registrationVM.passwordLengthValid ? Color.green : Color.red ,formText: "Mínimo 8 carácteres", conditionChecked: registrationVM.passwordLengthValid)
                    ValidationFormView(iconName: registrationVM.passwordCapitalLetter ? "checkmark.circle" : "xmark.circle", iconColor: registrationVM.passwordCapitalLetter ? Color.green : Color.red, formText: "Una mayúscula y una minúscula", conditionChecked: registrationVM.passwordCapitalLetter)
                }
                .padding(.top, 0)
                .padding(.bottom, 20)
                .padding(.horizontal)
                
                
                //Campo confirmación de contraseña
                SingleFormView(fieldValue: $registrationVM.confirmPassword, fieldName: "Confirmar contraseña", isProtected: true)
                ValidationFormView(iconName: registrationVM.passwordsMatch ? "checkmark.circle" : "xmark.circle", iconColor: registrationVM.passwordsMatch ? Color.green : Color.red, formText: "Las dos contraseñas deben coicidir", conditionChecked: registrationVM.passwordsMatch)
                    .padding(.top, 0)
                    .padding(.bottom, 30)
                    .padding(.horizontal)
            }
            
            VStack {
                Button(action: {
                   // To do
                }, label: {
                    Text("Registrar")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.black)
                        .bold()
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color(red: 10/255, green: 170/255, blue: 150/255))
                        .clipShape(Capsule())
                        .shadow(color: .black, radius: 2, x: 0.0, y: 2)
                })
                
                Button(action: {
                    //To do
                }, label: {
                    Text("¿Ya tienes cuenta?")
                        .foregroundColor(.gray)
                })
                .padding(.top, 10)
            }
            
            Spacer(minLength: 0)
        }
        .background(Color(red: 25/255, green: 25/255, blue: 37/255))
        .ignoresSafeArea(.all, edges: .all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Estructura para el diseño del formulario
struct SingleFormView: View {
    
    @Binding var fieldValue: String
    var fieldName = ""
    var isProtected = false
    
    var body: some View {
        VStack {
            if isProtected {
                HStack {
                    Image(systemName: "lock")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    SecureField(fieldName, text: $fieldValue)
                        .foregroundColor(.white)
                        .font(.system(size: 18, design: .rounded))
                        .padding(.horizontal)
                }
                .padding()
                .background(Color.white.opacity(fieldValue == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
            } else {
                HStack {
                    Image(systemName: "person")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    TextField(fieldName, text: $fieldValue)
                        .foregroundColor(.white)
                        .font(.system(size: 18, design: .rounded))
                        .padding(.horizontal)
                }
                .padding()
                .background(Color.white.opacity(fieldValue == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
            }
        }
        
    }
}

//Estructura para los requisitos de nombre de usuario y contraseña
struct ValidationFormView: View {
    
    
    var iconName = "xmark.circle"
    var iconColor = Color(red: 0.9, green: 0.5, blue: 0.5)
    var formText = ""
    var conditionChecked = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
                .font(.system(size: 14))
            Text(formText)
                .font(.system(size: 14, design: .rounded))
                .foregroundColor(.gray)
                .strikethrough(conditionChecked) 
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
