//
//  ProjectViewModel.swift
//  GREBAsset
//
//  Created by Guillermo Molina on 5/9/23.
//

import Foundation

class ProjectListViewModel: ObservableObject {
		
		@Published var entities = [Project]()
		@Published var searchText: String = ""
		
		var filteredProjects: [Project] {
				guard !searchText.isEmpty else { return entities}
				return entities.filter { meal in
						meal.name.lowercased().contains(searchText.lowercased())
				}
		}
		
		@Published var suggestions = ["char", "prop", "asset"]
		
		var filteredSuggestions: [String] {
				guard !searchText.isEmpty else { return [] }
				return suggestions.sorted().filter { $0.lowercased().contains(searchText.lowercased()) }
		}
		
		private let service = DataService()
		
		init() {
				load_entities()
		}
	func load_entities(){
			let entities_data = ["personal": ["indeleble"] ]
			load_entities_from_data(entities_data: entities_data)
//			return entities
		}
		
		
	
	func load_entities_from_data(entities_data: [String: [String]]){
		
		for (category, entityNames) in entities_data {
			for entityName in entityNames {
				let entityInstance = Project(name: entityName, category: category)
				self.entities.append(entityInstance)  // Explicitly refer to class property with 'self.'
			}
		}
}
}