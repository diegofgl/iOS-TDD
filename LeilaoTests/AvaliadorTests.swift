//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Diego Rodrigues on 29/09/23.
//  Copyright © 2023 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

final class AvaliadorTests: XCTestCase {
    
    var leiloeiro: Avaliador!
    private var joao: Usuario!
    private var jose: Usuario!
    private var maria: Usuario!

    override func setUpWithError() throws {
        leiloeiro = Avaliador()
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
    }

    override func tearDownWithError() throws {
       
    }

    func testDeveEntenderLancesEmOrdemCrescente() {
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 1000.0))
        leilao.propoe(lance: Lance(joao, 1200.0))
        leilao.propoe(lance: Lance(jose, 3000.0))
    
       try? leiloeiro.avalia(leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(3000.0, leiloeiro.maiorLance())
    }

    func testDeveEntenderLeilaoApenasUmLance() {
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(joao, 1000.0))
        
        try? leiloeiro.avalia(leilao)

        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())

    }
    
    func testDeveEncontrarOsTresMaioresLances() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 5")
                                            .lance(joao, 300.0)
                                            .lance(maria, 400.0)
                                            .lance(joao, 500.0)
                                            .lance(maria, 600.0)
                                            .constroi()
        
        try? leiloeiro.avalia(leilao)

        let listaDeLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaDeLances.count)
        XCTAssertEqual(600.0, listaDeLances[0].valor)
        XCTAssertEqual(500.0, listaDeLances[1].valor)
        XCTAssertEqual(400.0, listaDeLances[2].valor)
    }
    
    func testDeveIgnorarLeilaoSemNenhumLance() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 5").constroi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao), "Não é possivel avaliar um leilão sem lances") { error in
            print(error.localizedDescription)
        }
    }
}
