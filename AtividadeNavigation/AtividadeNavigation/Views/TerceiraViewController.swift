//
//  TerceiraViewController.swift
//  AtividadeNavigation
//
//  Created by COTEMIG on 17/05/23.
//

import UIKit
protocol TerceiraViewControllerDelegate : AnyObject {
    func deleteItem(livro: Livro)
}

class TerceiraViewController: UIViewController {
    weak var delegate: TerceiraViewControllerDelegate? = nil
    var livro:Livro? = nil
    @IBOutlet weak var lblMensagem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = livro {
            lblMensagem.text = "- \(item.titulo) \n - \(item.autor) \n - \(item.DataEdicao) \n - \(item.ISBN)"
        }

    }
    func  showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: {_ in 
            if let item = self.livro,
               let delegateNaoNulo = self.delegate{
                
                delegateNaoNulo.deleteItem(livro: item)
            }
             self.navigationController?.popViewController(animated: true)
        })
        let action2 = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        DispatchQueue.main.async {
            self.present(alert,animated: true, completion: nil)
        }
    }
    @IBAction func btnVoltar(_ sender: Any) {
      showAlert(title: "Deletar", message: "Tem certeza que deseja deletar o item?")
        
    }
}
