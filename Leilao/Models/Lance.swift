//
//  Lance.swift
//  Leilao
//
//  Created by Diego Rodrigues on 04/10/23.
//  Copyright © 2023 Alura. All rights reserved.
//

import Foundation

class Lance {
    
    let usuario:Usuario
    let valor:Double
    
    init(_ usuario:Usuario, _ valor:Double) {
        self.usuario = usuario
        self.valor = valor
    }
}
