//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Diego Rodrigues on 04/10/23.
//  Copyright © 2023 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

final class LeilaoTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testDevereceberUmLance() {
        let leilao = Leilao(descricao: "Playstation 5")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let lucas = Usuario(nome: "Lucas")
        leilao.propoe(lance: Lance(lucas, 2000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances() {
        
        let leilao = Leilao(descricao: "Macbook Pro 16")
        
        let leticia = Usuario(nome: "Leticia")
        leilao.propoe(lance: Lance(leticia, 2000))
        
        let diego = Usuario(nome: "Diego")
        leilao.propoe(lance: Lance(diego, 3000))
        
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
        XCTAssertEqual(3000, leilao.lances?[1].valor)
    }
    
    func testDeveIgnorarDoisLancesSeguidosdoMesmoUsuario() {
        let leilao = Leilao(descricao: "Macbook Pro 16")
        let maria = Usuario(nome: "Maria")
        
        leilao.propoe(lance: Lance(maria, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
    }
    
    func testDeveIgnorarMaisDoQue5LancesDoMesmoUsuario() {
        
        let leilao = Leilao(descricao: "Macbook Pro 16 - M1")
        
        let jose = Usuario(nome: "José")
        let maria = Usuario(nome: "Maria")
        
        leilao.propoe(lance: Lance(jose, 2000.0))
        leilao.propoe(lance: Lance(maria, 3000.0))
        
        leilao.propoe(lance: Lance(jose, 4000.0))
        leilao.propoe(lance: Lance(maria, 5000.0))
        
        leilao.propoe(lance: Lance(jose, 6000.0))
        leilao.propoe(lance: Lance(maria, 7000.0))

        leilao.propoe(lance: Lance(jose, 8000.0))
        leilao.propoe(lance: Lance(maria, 9000.0))
        
        leilao.propoe(lance: Lance(jose, 10000.0))
        leilao.propoe(lance: Lance(maria, 11000.0))

        //ignorar
        
        leilao.propoe(lance: Lance(jose, 12000))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(11000.0, leilao.lances?.last?.valor)

    }
}
