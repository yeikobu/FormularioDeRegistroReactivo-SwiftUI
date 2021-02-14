//
//  RegistrationViewModel.swift
//  Vista de registro
//
//  Created by Jacob Aguilar on 14-02-21.
//

import Foundation
import Combine

//Clase tipo: ObservableObject para interfaz dinámica 
class RegistrationViewModel: ObservableObject {
    
    //Entrada de datos del usuario
    @Published var userName = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    //Valores de validación del formulario
    @Published var userNameLengthValid = false
    @Published var passwordLengthValid = false
    @Published var passwordCapitalLetter = false
    @Published var passwordsMatch = false
    
    private var cancellableObjects: Set<AnyCancellable> = []
    
    init() {
        $userName
            .receive(on: RunLoop.main)
            .map { userName in
                return userName.count >= 6
            }
            .assign(to: \.userNameLengthValid, on: self)
            .store(in: &cancellableObjects)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.passwordLengthValid, on: self)
            .store(in: &cancellableObjects)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]" //Expresión regular para saber si contiene mayúsculas
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.passwordCapitalLetter, on: self)
            .store(in: &cancellableObjects)
        
        Publishers.CombineLatest($password, $confirmPassword) //De esta manera podemos combinar dos published y así podemos comparar las contraseñas
            .receive(on: RunLoop.main)
            .map { (password, confirmPassword) in
                return !password.isEmpty && (password == confirmPassword)
            }
            .assign(to: \.passwordsMatch, on: self)
            .store(in: &cancellableObjects)
    }

}
    
