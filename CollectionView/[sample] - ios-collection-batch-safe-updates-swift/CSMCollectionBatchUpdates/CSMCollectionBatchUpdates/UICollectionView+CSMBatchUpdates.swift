//
//  UICollectionView+CSMBatchUpdates.swift
//  CSMCollectionBatchUpdates
//
//  Created by Carlos Simon Villas on 11/04/16.
//  Copyright © 2016 Charlisim. All rights reserved.
//

import Foundation


extension UICollectionView{
    
    func csm_performBatchUpdates(updates:[CSMCollectionUpdate],
                                 applyChangesToModelBlock:()->Void,
                                 reloadCellBlock:(_ cell:UICollectionViewCell, _ indexPath: IndexPath)->Void,
                                 completionBlock:@escaping (_ finished:Bool)->Void){
        if updates.isEmpty{
            applyChangesToModelBlock()
            self.reloadData()
            completionBlock(true)
        }else{
            self.performBatchUpdates({ 
                applyChangesToModelBlock()
                
                for update in updates{
                    if let itemUpdate = update as? CSMCollectionItemUpdate{
                        self.updateItems(itemUpdate, reloadCellBlock: reloadCellBlock)
                    }
                    if let sectionUpdate = update as? CSMCollectionSectionUpdate{
                        self.updateSections(sectionUpdate)
                    }
                }
                }, completion: completionBlock)
        }
    }
    
    private func updateItems(_ itemUpdate:CSMCollectionItemUpdate, reloadCellBlock:(_ cell:UICollectionViewCell, _ indexPath: IndexPath) -> Void){
        
        switch itemUpdate.type {
        case .Reload:
            if let indexPath = itemUpdate.indexPath, let cell = self.cellForItem(at: indexPath){
                reloadCellBlock(cell, indexPath)
            }
            
        case .Delete:
            if let indexPath = itemUpdate.indexPath {
                self.deleteItems(at: [indexPath])
            }
        case .Insert:
            if let indexPath = itemUpdate.indexPathNew{
                self.insertItems(at: [indexPath])
            }
        case .Move:
            if let indexPath = itemUpdate.indexPathNew, let newIndexPath = itemUpdate.indexPathNew{
                self.moveItem(at: indexPath, to: newIndexPath)
            }

        }
    }
    private func updateSections(_ sectionUpdate:CSMCollectionSectionUpdate){
        switch sectionUpdate.type {
        case .Reload:
            self.reloadSections(IndexSet(integer: sectionUpdate.sectionIndex))
            
        case .Delete:
            self.deleteSections(IndexSet(integer: sectionUpdate.sectionIndex))
        
        case .Insert:
            self.insertSections(IndexSet(integer: sectionUpdate.sectionIndexNew))
            
        case .Move:
            self.moveSection(sectionUpdate.sectionIndex, toSection: sectionUpdate.sectionIndexNew)
        }
    }
}
