//
//  SafetyReport.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 06.05.2024.
//

import Foundation

struct SafetyReport: Codable {
    let safetyreportid: String
    let transmissiondate: String
    let serious: String
    let seriousnessdeath: String
    let receivedate: String
    let receiptdate: String
    let fulfillexpeditecriteria: String
    let companynumb: String
    let primarysource: PrimarySource
    let sender: Sender
    let receiver: String?
    let patient: Patient
}

struct PrimarySource: Codable {
    let reportercountry: String
    let qualification: String
}

struct Sender: Codable {
    let senderorganization: String
}

struct Patient: Codable {
    let patientonsetage: String
    let patientonsetageunit: String
    let patientsex: String
    let patientdeath: PatientDeath?
    let reaction: [Reaction]
    let drug: [Drug]
}

struct PatientDeath: Codable {
    let patientdeathdateformat: String?
    let patientdeathdate: String?
}

struct Reaction: Codable {
    let reactionmeddrapt: String
}

struct Drug: Codable {
    let drugcharacterization: String
    let medicinalproduct: String
    let drugauthorizationnumb: String
    let drugadministrationroute: String
    let drugindication: String
}

struct SafetyReportResponse: Codable {
    let meta: Meta
    let results: [SafetyReport]
}

struct Meta: Codable {
    let disclaimer: String
    let terms: String
    let license: String
    let last_updated: String
    let results: MetaResults
}

struct MetaResults: Codable {
    let skip: Int
    let limit: Int
    let total: Int
}

