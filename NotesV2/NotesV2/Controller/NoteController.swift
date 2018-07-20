//
//  NoteController.swift
//  NotesV2
//
//  Created by Owen Henley on 7/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

class NoteController {
    
    static let shared = NoteController()
    
    var notes: [Note] = []
    
    func makeNewNoteWith(newNote: String) {
        let newNote = Note(bodytext: newNote)
        notes.append(newNote)
        saveToPersistantStore()
    }

    func deleteNote(noteToDelete: Note) {
        guard let noteToDelete = notes.index(of: noteToDelete) else { return }
        notes.remove(at: noteToDelete)
        saveToPersistantStore()
    }
    
    func editNote(noteToUpdate: Note, noteBodyToUpdate: String) {
        noteToUpdate.bodyText = noteBodyToUpdate
        saveToPersistantStore()
    }
    
    // MARK: - Persistance
    private func fileURL() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDirectory = paths[0]
        
        let noteLocation = "note.json"
        
        let url = documentDirectory.appendingPathComponent(noteLocation)
        print(url.absoluteString)
        
        return url
    }
    
    func saveToPersistantStore() {
        
        let jsonEncoder = JSONEncoder()
        do {
            
            let data = try jsonEncoder.encode(notes)
            try data.write(to: fileURL())
        } catch {
            print("There was an error saving to the persistent store: \(error.localizedDescription)")
        }
    }
    
    //load
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let notesFromDecoder = try jsonDecoder.decode([Note].self, from: data)
            
            notes = notesFromDecoder
            
        } catch {
            print("There was an error saving to the persistent store: \(error.localizedDescription)")
        }
    }
}
