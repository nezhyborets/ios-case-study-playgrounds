//
//  ViewController.swift
//  CoreDataRelationshipUpdate
//
//  Created by Nezhyborets Oleksii on 6/5/19.
//  Copyright © 2019 nezhyborets. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    private let tableView = UITableView(frame: .zero, style: .plain)

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var frc = NSFetchedResultsController<Asset>(
        fetchRequest: {
            let fetchRequest: NSFetchRequest<Asset> = NSFetchRequest(entityName: "Asset")
            fetchRequest.predicate = NSPredicate(format: "hidden == NO AND album.hidden == NO")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "hidden", ascending: false)]
            return fetchRequest
        }(),
        managedObjectContext: self.context,
        sectionNameKeyPath: nil,
        cacheName: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AssetCell")
        view.addSubview(tableView)

        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonAction))

        frc.delegate = self
        try! frc.performFetch()
        tableView.reloadData()
    }

    @objc func onAddButtonAction() {
        let newAsset = Asset(context: self.context)
        newAsset.album = Album(context: self.context)
        try? context.save()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return frc.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = frc.sections else { return 0 }
        return sections[section].numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCell", for: indexPath)
        configureCell(cell, at: indexPath)
        return cell
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert: tableView.insertSections(.init(integer: sectionIndex), with: .fade)
        case .delete: tableView.deleteSections(.init(integer: sectionIndex), with: .fade)
        default: fatalError()
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            configureCell(tableView.cellForRow(at: indexPath!)!, at: indexPath!)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        @unknown default:
            fatalError()
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let asset = frc.object(at: indexPath)
        cell.textLabel?.text = "Asset hidden \(asset.hidden), Album hidden \(asset.album!.hidden)"
        cell.accessoryType = .detailButton
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let asset = frc.object(at: indexPath)
        asset.hidden = !asset.hidden
        try! context.save()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let album = frc.object(at: indexPath).album else { assert(false); return }
        album.hidden = !album.hidden
        try! context.save()
    }
}

