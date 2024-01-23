//
//  Prospects.swift
//  HotProspects
//
//  Created by Ramanan on 31/01/23.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    //challenge
    enum ContactFilterType {
        case none,name,latest
    }
   @State var contactFilter: ContactFilterType
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    let filter: FilterType
    
    @State private var showActionSheet = false //challenge
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProsepects) { prospect in
                    HStack {
                        if filter == .none {
                         Label("", systemImage: "circle.fill")
                                .foregroundColor(prospect.isContacted ? .green : .orange)
                        }//challenge
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isShowingScanner = true
                        /*
                        let prospect = Prospect()
                        prospect.name = "Paul Hudson"
                        prospect.emailAddress = "paul@hackingwithswift.com"
                        prospects.people.append(prospect)
                        */
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                    
                    Button {
                        showActionSheet = true
                    } label: {
                        Label("Filter", systemImage: "sparkles")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Tim Cook\ntim@hackingwithswift.com",completion: handleScan)
            }
            .confirmationDialog("Filter",isPresented: $showActionSheet) {
                Button("None") { contactFilter = .none }
                Button("Name") { contactFilter = .name }
                Button("Latest") { contactFilter = .latest }
            } message: {
                Text("Filter")
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProsepects: [Prospect] {
        switch filter {
        case .none:
            if contactFilter == .name { //challenge
                return prospects.people.sorted()
            } else if contactFilter == .latest {
                return prospects.people.reversed()
            }
            return prospects.people
        case .contacted:
            if contactFilter == .name { //challenge
                return prospects.people.filter { $0.isContacted }.sorted()
            } else if contactFilter == .latest {
                return prospects.people.filter { $0.isContacted }.reversed()
            }
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            if contactFilter == .name { //challenge
                return prospects.people.filter { !$0.isContacted }.sorted()
            } else if contactFilter == .latest {
                return prospects.people.filter { !$0.isContacted }.reversed()
            }
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
            //prospects.people.append(person)
            //prospects.save()
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
            
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            
            var dateCompnents = DateComponents()
            dateCompnents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompnents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh!")
                    }
                }
            }
        }
        
    }
    
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(contactFilter: .none, filter: .none)
            .preferredColorScheme(.dark)
            .environmentObject(Prospects())
    }
}
