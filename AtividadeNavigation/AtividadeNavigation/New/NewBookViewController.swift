//
//  NewBookViewController.swift
//  AtividadeNavigation
//
//  Created by COTEMIG on 31/05/23.
//

import UIKit
protocol NewBookViewControllerDelegate: AnyObject {
    func saveNew(livro: Livro)
}

class NewBookViewController: UIViewController {
    
    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtAutor: UITextField!
    @IBOutlet weak var txtDataEdicao: UITextField!
    @IBOutlet weak var txtISBN: UITextField!
    
    weak var delegate : NewBookViewControllerDelegate?
    var livro : Livro? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Novo Livro"
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        
        if let titulo = txtTitulo.text,
           let autor = txtAutor.text,
           let dataEdicao = txtDataEdicao.text,
           let isbn = txtISBN.text,!titulo.isEmpty && !autor.isEmpty && !dataEdicao.isEmpty && !isbn.isEmpty {
            let item = Livro(titulo: titulo, autor: autor, DataEdicao: dataEdicao, ISBN: isbn); delegate?.saveNew(livro: item); self.navigationController?.popViewController(animated : true)
        }
    }
    

}
