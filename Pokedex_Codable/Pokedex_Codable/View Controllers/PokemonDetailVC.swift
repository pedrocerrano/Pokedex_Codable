//
//  PokemonDetailVC.swift
//  Pokedex_Codable
//
//  Created by iMac Pro on 2/28/23.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonMovesTableView.dataSource = self
        pokemonMovesTableView.delegate = self
    }
    
    
    //MARK: - PROPERTIES
    var pokemon: Pokemon? {
        didSet {
            updateUI()
        }
    }
    
    
    //MARK: - FUNCTIONS
    func updateUI() {
        guard let pokemon = pokemon else { return }
        NetworkingController.fetchSprite(for: pokemon.sprites.frontShiny) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonNameLabel.text          = pokemon.name
                    self.pokemonIDLabel.text            = "\(pokemon.id)"
                    self.pokemonSpriteImageView.image   = image
                    self.pokemonMovesTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
    
    
} //: CLASS


//MARK: - EXT: TableViewDataSource
extension PokemonDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        
        //        var config  = cell.defaultContentConfiguration()
        //        let move    = pokemon?.moves[indexPath.row]
        //        config.text = move
        //        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Moves:"
    }
} //: EXT TableViewDataSource

