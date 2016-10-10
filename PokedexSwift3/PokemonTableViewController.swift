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
import PromiseKit

class PokemonTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
    // MARK: Properties
    var itens = [Pokemon]()
    
    var pokedexJson:NSDictionary = [:]
    var typesCsv:[[String:String]] = []

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
        
        cell.type1.pokemonType = pokemon.typeSlot1
        cell.type2.pokemonType = pokemon.typeSlot2
        
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
        startAnimating()
        
        _ = loadPokemonList().then { r -> Promise<Bool> in
            return self.loadPokemonTypes()
        }.then { r -> Promise<Bool> in
            return self.renderTableView()
        }.then { r -> Void in
            self.tableView.reloadData()
            self.stopAnimating()
        }
    }
    
    func loadPokemonList() -> Promise<Bool> {
        return Promise{ fulfill, reject in
            Alamofire.request("https://pokeapi.co/api/v2/pokedex/1/", method: .get, encoding: JSONEncoding.default).responseJSON { response in
                if let json = response.result.value {
                    self.pokedexJson = json as! NSDictionary
                    fulfill(true)
                } else {
                    reject(response.result.error!)
                }
            }
        }
    }
    
    func loadPokemonTypes() -> Promise<Bool> {
        return Promise{ fulfill, reject in
            Alamofire.request("https://raw.githubusercontent.com/PokeAPI/pokeapi/master/data/v2/csv/pokemon_types.csv", method: .get).responseString { response in
                if let csvTypes = response.result.value {
                    
                    //let csv = CSwiftV(String: csvTipes)
                    let csv = CSwiftV(with: csvTypes)
                    self.typesCsv = csv.keyedRows!
                    
                    fulfill(true)
                } else {
                    reject(response.result.error!)
                }
            }
        }
    }
    
    func renderTableView() -> Promise<Bool> {
        return Promise{ fulfill, reject in
            if let pokemon_entries = self.pokedexJson["pokemon_entries"] as? [[String:AnyObject]] {
            
                for (_, pokemon_entry) in pokemon_entries.enumerated() {
                    
                    let pokemon:Pokemon
                    if let pokemon_species = pokemon_entry["pokemon_species"] as? [String:String] {
                        pokemon = Pokemon(number: pokemon_entry["entry_number"] as! Int, name: pokemon_species["name"]!.capitalized)
                    } else {
                        fulfill(false)
                        return
                    }
                    
                    
                    // Search for types of pokemon
                    let numberString = String(describing: pokemon.number)
                    for (_, pokemonType) in self.typesCsv.enumerated() {
                        if pokemonType["pokemon_id"] == numberString {
                            if pokemonType["slot"] == "1" {
                                pokemon.typeSlot1 = Int(pokemonType["type_id"]!)!
                            } else if pokemonType["slot"] == "2" {
                                pokemon.typeSlot2 = Int(pokemonType["type_id"]!)!
                            }
                        }
                    }
                    self.itens += [pokemon]
                }
                
                fulfill(true)
            
            } else {
                fulfill(false)
            }
        }
    }

}
