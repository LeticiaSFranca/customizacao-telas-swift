//
//  ViewController.swift
//  AtividadeNavigation
//
//  Created by COTEMIG on 17/05/23.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBAction func btnAdd(_ sender: Any) {
        
        let view = NewBookViewController()
        view.delegate = self
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CelulaCustomizada {
            let item = lista[indexPath.row]
            cell.carregar(livro: item)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = lista[indexPath.row]
        let vc = TerceiraViewController()
        vc.livro = item
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    var lista: [Livro] = []
    var userDefault = UserDefaults.standard
    var listKey = "Livro"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "HOME"
        carregar()
    }
    
    func carregar(){
        guard let listData = userDefault.value(forKey: listKey) as? Data else {
            lista = []
            return
        }
        do {
            let savedLista = try JSONDecoder().decode([Livro].self, from: listData)
            lista = savedLista
            tableView.reloadData()
        } catch {
            print("Erro ao recuperar dados.")
        }
        
        //let item1 = Livro(titulo: "Harry Potter", autor: "Cavalo de Guerra", DataEdicao: "2000", ISBN: "999")
        
        //let item2 = Livro(titulo: "Percy Jackson", autor: "Anne With an E", DataEdicao: "2001", ISBN: "999")
        
        //let item3 = Livro(titulo: "Jogos Vorazes", autor: "Novembro 9", DataEdicao: "2002", ISBN: "999")
        
        //let item4 = Livro(titulo: "As Cronicas de Narnia", autor: "O Lado Feio do Amor", DataEdicao: "2003", ISBN: "999")
        
        //let item5 = Livro(titulo: "Divergente", autor: "As Crônicas de Nárnia", DataEdicao: "2004", ISBN: "999")
        
        //lista.append(item1)
        //lista.append(item2)
        //lista.append(item3)
        //lista.append(item4)
        //lista.append(item5)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }

}

extension ViewController: TerceiraViewControllerDelegate{
    func deleteItem(livro: Livro){
        let indice: Int
        indice = lista.firstIndex(where: {$0.autor == livro.autor}) ?? 0
        
        self.lista.removeAll( where : {$0.autor == livro.autor})
        do {
            let serializedList = try JSONEncoder().encode(lista)
            userDefault.setValue(serializedList, forKey: listKey)
        } catch {
            self.lista.insert(livro, at: indice)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            guard let context = self else {
                return
            }
            context.tableView.reloadData()
        })
    }
}

extension ViewController: NewBookViewControllerDelegate {
    func saveNew(livro: Livro) {
        lista.append(livro)
        do {
            let serializedList = try JSONEncoder().encode(lista)
            userDefault.setValue(serializedList, forKey: listKey)
        } catch {
            lista.removeAll(where: {$0.autor==livro.autor})
        }
        self.tableView.reloadData()
    }
}
