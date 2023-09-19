//
//  CelulaCustomizada.swift
//  AtividadeNavigation
//
//  Created by COTEMIG on 17/05/23.
//

import UIKit

class CelulaCustomizada: UITableViewCell {

    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var lblDataEdicao: UILabel!
    
    func carregar(livro: Livro){
        lblTitulo.text = livro.titulo
        lblAutor.text = "\(livro.autor) - \(livro.DataEdicao)"
        lblDataEdicao.text = livro.ISBN
    }
    
}
