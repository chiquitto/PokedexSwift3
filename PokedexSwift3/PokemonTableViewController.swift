//
//  PokemonTableViewController.swift
//  PokedexSwift3
//
//  Created by Alisson Chiquitto on 09/10/16.
//  Copyright © 2016 Alisson Chiquitto. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class PokemonTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
    // MARK: Properties
    var itens = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itens.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PokemonTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PokemonTableViewCell
        
        let pokemon = itens[indexPath.row]
        cell.nameLabel.text = "#" + String(format: "%02d", pokemon.number) + " - " + pokemon.name
        
        cell.type1.pokemonType = "normal"
        cell.type2.pokemonType = "ground"
        
        // Load image in UIImageView
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + String(pokemon.number) + ".png")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.photo.image = UIImage(data: data!)
            }
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadData() {
        // startAnimating(CGSize(width: 30, height:30), message: "Carregando")
        startAnimating()
        
        Alamofire.request("https://pokeapi.co/api/v2/pokedex/1/", method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    
                    /*
                    let pokemon_entries = JSON["pokemon_entries"] as! NSArray
                    let pokemon_entry = pokemon_entries[0] as! NSDictionary
                    print(pokemon_entry["entry_number"]!)
                    print(pokemon_entry["pokemon_species"]!)*/
                    
                    // as? Array<Dictionary<String, String>>
                    if let pokemon_entries = JSON["pokemon_entries"] as? [[String:AnyObject]] {
                        
                        for (_, pokemon_entry) in pokemon_entries.enumerated() {
                            
                            if let pokemon_species = pokemon_entry["pokemon_species"] as? [String:String] {
                                self.itens += [Pokemon(number: pokemon_entry["entry_number"] as! Int, name: pokemon_species["name"]!.capitalized)]
                            } else {
                                print("ERRO")
                            }
                        }
                        
                        self.tableView.reloadData()
                        self.stopAnimating()
                        
                    } else {
                        print("ERRO")
                    }
                }
                
        }
        
        /*let pokemon1 = Pokemon(number: 1, name: "Bulbasaur")
        let pokemon4 = Pokemon(number: 4, name: "Charmander")
        let pokemon7 = Pokemon(number: 7, name: "Squirtle")
        
        itens += [pokemon1, pokemon4, pokemon7]*/
    }
    
    /*func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            DispatchQueue.main.sync() { () -> Void in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                self.imageView.image = UIImage(data: data)
            }
        }
    }*/

}
