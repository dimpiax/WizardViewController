//
//  TutorialPageContent.swift
//  Pods
//
//  Created by Pilipenko Dima on 10/20/16.
//
//

import Foundation

public protocol WizardPageContent {
    func pageWillAppear(animated: Bool)
    func pageWillDisappear(animated: Bool)
}
