//
//  Avaliador.swift
//  Leilao
//
//  Created by Diego Rodrigues on 04/10/23.
//  Copyright © 2023 Alura. All rights reserved.
//

import Foundation

enum ErroAvaliador: Error {
    case LeilãoSemNenhumLance(String)
}

class Avaliador {
    
    private var maiorDeTodos = Double.leastNonzeroMagnitude
    private var menorDeTodos = Double.greatestFiniteMagnitude
    private var maiores: [Lance] = []
    
    func avalia(_ leilao: Leilao)  throws {
        
        if leilao.lances?.count == 0 {
            throw ErroAvaliador.LeilãoSemNenhumLance("Não é possivel avaliar um leilão sem lances")
        }
        
        guard let lances = leilao.lances else { return }
        
        for lance in lances {
            if lance.valor > maiorDeTodos {
                maiorDeTodos = lance.valor
            }
            if lance.valor < menorDeTodos {
                menorDeTodos = lance.valor
            }
            
            pegaOsMaioresLancesNoLeilao(leilao)
        }
    }
    
    func maiorLance() -> Double {
        return maiorDeTodos
    }
    
    func menorLance() -> Double {
        return menorDeTodos
    }
    
    private func pegaOsMaioresLancesNoLeilao(_ leilao: Leilao) {
        
        guard let lances = leilao.lances else { return }
        
        maiores = lances.sorted(by: { lista1, lista2 in
            return lista1.valor > lista2.valor
        })
        
        let maioresLances = maiores.prefix(3)
        maiores = Array(maioresLances)
    }
    
    func tresMaiores() -> [Lance] {
        return maiores
    }
    
}
