//
//  ContentView.swift
//  HarshPatelFinalProject
//
//  Created by Harsh Patel on 5/22/23.
//

import SwiftUI
import UserNotifications
import EventKit

enum Frequency: String, CaseIterable, Codable {
    case daily = "Daily"
    case everyTwoDays = "Every Two Days"
    case everyThreeDays = "Every Three Days"
    case everyFourDays = "Every Four Days"
    case everyFiveDays = "Every Five Days"
    case everySixDays = "Every Six Days"
    case weekly = "Weekly"
    
    var days: Int {
        switch self {
        case .daily:
            return 1
        case .everyTwoDays:
            return 2
        case .everyThreeDays:
            return 3
        case .everyFourDays:
            return 4
        case .everyFiveDays:
            return 5
        case .everySixDays:
            return 6
        case .weekly:
            return 7
        }
    }

}

struct Medication: Identifiable, Hashable, Codable {
    var id = UUID()
    let name: String
    var frequency: Frequency
    var hour: Int
    var minute: Int
    let sideEffects: String
}

struct MedicationModel: Hashable, Codable, Equatable {
    let name: String
    let sideEffects: String
    let purpose: String
}

struct ContentView: View {
    @State var medications: [Medication] = []
    @State var commonMedications: [MedicationModel] = [
        MedicationModel(name: "Acetaminophen", sideEffects: "Upset stomach, nausea, or headache may occur.", purpose: "Pain reliever and fever reducer"),
        MedicationModel(name: "Albuterol", sideEffects: "Nervousness, shaking (tremor), headache, mouth/throat dryness or irritation, changes in taste, cough, nausea or dizziness may occur.", purpose: "Bronchodilator used to treat asthma and other breathing problems"),
        MedicationModel(name: "Amoxicillin", sideEffects: "Nausea, vomiting, diarrhea, or stomach pain may occur.", purpose: "Antibiotic used to treat bacterial infections"),
        MedicationModel(name: "Aspirin", sideEffects: "Upset stomach, heartburn, or mild stomach pain may occur.", purpose: "Pain reliever, anti-inflammatory, and fever reducer"),
        MedicationModel(name: "Atorvastatin", sideEffects: "Constipation, diarrhea, or upset stomach may occur.", purpose: "Cholesterol-lowering medication"),
        MedicationModel(name: "Azithromycin", sideEffects: "Nausea, vomiting, diarrhea, or stomach pain may occur.", purpose: "Antibiotic used to treat bacterial infections"),
        MedicationModel(name: "Cephalexin", sideEffects: "Diarrhea, nausea, or stomach upset may occur.", purpose: "Antibiotic used to treat bacterial infections"),
        MedicationModel(name: "Cetirizine", sideEffects: "Drowsiness, tiredness, or dry mouth may occur.", purpose: "Antihistamine used to relieve allergy symptoms"),
        MedicationModel(name: "Codeine", sideEffects: "Nausea, vomiting, constipation, lightheadedness, or dizziness may occur.", purpose: "Opioid pain medication and cough suppressant"),
        MedicationModel(name: "Diazepam", sideEffects: "Drowsiness, dizziness, tiredness, or unsteadiness may occur.", purpose: "Benzodiazepine used to treat anxiety and seizures"),
        MedicationModel(name: "Diphenhydramine", sideEffects: "Drowsiness, dizziness, headache, dry mouth, or difficulty urinating may occur.", purpose: "Antihistamine used to relieve allergy symptoms and aid sleep"),
        MedicationModel(name: "Doxycycline", sideEffects: "Nausea, vomiting, upset stomach, or diarrhea may occur.", purpose: "Antibiotic used to treat bacterial infections"),
        MedicationModel(name: "Esomeprazole", sideEffects: "Headache, diarrhea, stomach pain, or nausea may occur.", purpose: "Proton pump inhibitor used to reduce stomach acid"),
        MedicationModel(name: "Fexofenadine", sideEffects: "Headache, dizziness, or nausea may occur.", purpose: "Antihistamine used to relieve allergy symptoms"),
        MedicationModel(name: "Fluoxetine", sideEffects: "Nausea, diarrhea, dry mouth, or trouble sleeping may occur.", purpose: "Selective serotonin reuptake inhibitor (SSRI) used to treat depression and anxiety"),
        MedicationModel(name: "Gabapentin", sideEffects: "Drowsiness, dizziness, loss of coordination, tiredness, blurred/double vision, unusual eye movements, or shaking (tremor) may occur.", purpose: "Anticonvulsant and nerve pain medication"),
        MedicationModel(name: "Hydrochlorothiazide", sideEffects: "Upset stomach, dizziness, or headache may occur as your body adjusts to the medication.", purpose: "Diuretic used to treat high blood pressure and fluid retention"),
        MedicationModel(name: "Ibuprofen", sideEffects: "Stomach pain, heartburn, nausea, or dizziness may occur.", purpose: "Nonsteroidal anti-inflammatory drug (NSAID) used to relieve pain and reduce inflammation"),
        MedicationModel(name: "Levothyroxine", sideEffects: "Hair loss may occur during the first few months of treatment.", purpose: "Thyroid hormone replacement used to treat hypothyroidism"),
        MedicationModel(name: "Lisinopril", sideEffects: "Dizziness, lightheadedness, tiredness, or headache may occur as your body adjusts to the medication.", purpose: "Angiotensin-converting enzyme (ACE) inhibitor used to treat high blood pressure and heart failure"),
        MedicationModel(name: "Loratadine", sideEffects: "Headache, tiredness, or dry mouth/nose/throat may occur.", purpose: "Antihistamine used to relieve allergy symptoms"),
        MedicationModel(name: "Metformin", sideEffects: "Nausea, vomiting, stomach upset, diarrhea, weakness, or a metallic taste in the mouth may occur.", purpose: "Oral diabetes medication used to control blood sugar levels"),
        MedicationModel(name: "Metoprolol", sideEffects: "Drowsiness, dizziness, tiredness, diarrhea, and slow heartbeat may occur.", purpose: "Beta-blocker used to treat high blood pressure and chest pain (angina)"),
        MedicationModel(name: "Naproxen", sideEffects: "Upset stomach, heartburn, or stomach pain may occur.", purpose: "Nonsteroidal anti-inflammatory drug (NSAID) used to relieve pain and reduce inflammation"),
        MedicationModel(name: "Omeprazole", sideEffects: "Headache or abdominal pain may occur.", purpose: "Proton pump inhibitor used to reduce stomach acid"),
        MedicationModel(name: "Ondansetron", sideEffects: "Headache, dizziness, or constipation may occur.", purpose: "Anti-nausea medication used to prevent and treat nausea and vomiting"),
        MedicationModel(name: "Pantoprazole", sideEffects: "Headache, diarrhea, stomach pain, or nausea may occur.", purpose: "Proton pump inhibitor used to reduce stomach acid"),
        MedicationModel(name: "Paroxetine", sideEffects: "Nausea, drowsiness, dizziness, or trouble sleeping may occur.", purpose: "Selective serotonin reuptake inhibitor (SSRI) used to treat depression, anxiety, and other conditions"),
        MedicationModel(name: "Prednisone", sideEffects: "Nausea, vomiting, loss of appetite, or stomach upset may occur.", purpose: "Corticosteroid used to treat inflammation, allergies, and immune system disorders"),
        MedicationModel(name: "Propranolol", sideEffects: "Dizziness, lightheadedness, or tiredness may occur.", purpose: "Beta-blocker used to treat high blood pressure, angina, and tremors"),
        MedicationModel(name: "Ranitidine", sideEffects: "Headache, constipation, or diarrhea may occur.", purpose: "H2 blocker used to reduce stomach acid and prevent heartburn"),
        MedicationModel(name: "Sertraline", sideEffects: "Nausea, diarrhea, upset stomach, or trouble sleeping may occur.", purpose: "Selective serotonin reuptake inhibitor (SSRI) used to treat depression, anxiety, and other conditions"),
        MedicationModel(name: "Simvastatin", sideEffects: "A very small number of people taking simvastatin may have mild memory problems or confusion.", purpose: "Cholesterol-lowering medication"),
        MedicationModel(name: "Tadalafil", sideEffects: "Headache, stomach upset, back pain, muscle pain, or flushing may occur.", purpose: "Medication used to treat erectile dysfunction and symptoms of enlarged prostate"),
        MedicationModel(name: "Tamsulosin", sideEffects: "Dizziness, lightheadedness, or abnormal ejaculation may occur.", purpose: "Alpha-blocker used to treat symptoms of enlarged prostate (benign prostatic hyperplasia)"),
        MedicationModel(name: "Tramadol", sideEffects: "Nausea, vomiting, constipation, lightheadedness, dizziness, drowsiness, or headache may occur.", purpose: "Opioid pain medication"),
        MedicationModel(name: "Valacyclovir", sideEffects: "Nausea, vomiting, headache, or diarrhea may occur.", purpose: "Antiviral medication used to treat herpes infections"),
        MedicationModel(name: "Venlafaxine", sideEffects: "Nausea, drowsiness, dizziness, or sweating may occur.", purpose: "Serotonin-norepinephrine reuptake inhibitor (SNRI) used to treat depression and anxiety"),
        MedicationModel(name: "Warfarin", sideEffects: "Bleeding, easy bruising, or black/tarry stools may occur.", purpose: "Anticoagulant (blood thinner) used to prevent blood clots"),
        MedicationModel(name: "Zolpidem", sideEffects: "Daytime drowsiness, dizziness, weakness, feeling 'drugged' or light-headed; tired feeling, loss of coordination.", purpose: "Sedative-hypnotic used to treat insomnia"),
    ]
    
    var body: some View {
        TabView {
            MedicationListView(medications: $medications, commonMedications: $commonMedications)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("My Medications")
                }
            MedicationDetailsView(commonMedications: $commonMedications)
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("Medication Details")
                }
        }
        .onAppear(perform: requestNotificationPermission)
    }
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Failed to request authorization for notifications: \(error.localizedDescription)")
            }
        }
    }
}

struct MedicationListView: View {
    @Binding var medications: [Medication]
    @Binding var commonMedications: [MedicationModel]
    @State private var showAlert: Bool = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(medications) { medication in
                    HStack {
                        Text(medication.name)
                        Spacer()
                        Text(medication.frequency.rawValue)
                        Text("\(medication.hour):\(medication.minute < 10 ? "0\(medication.minute)" : "\(medication.minute)")")
                    }
                }
                .onDelete(perform: deleteMedication)
            }
            .navigationTitle("My Medications")
            .navigationBarItems(leading: Button(action: syncWithCalendar) {
                Text("Sync Calendar")
            }, trailing: NavigationLink(destination: AddMedicationView(medications: $medications, commonMedications: $commonMedications)) {
                Image(systemName: "plus")
            })
        }
        .onAppear(perform: {
            loadMedications()
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func syncWithCalendar() {
        let eventStore = EKEventStore()

        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            removeExistingMedicationEvents(eventStore)
            insertMedicationsIntoCalendar(eventStore)
        case .denied, .restricted:
            showAlert = true
            alertTitle = "Permission Denied"
            alertMessage = "Calendar access is restricted or denied. Please enable it in Settings."
        case .notDetermined:
            eventStore.requestAccess(to: .event) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        self.removeExistingMedicationEvents(eventStore)
                        self.insertMedicationsIntoCalendar(eventStore)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert = true
                        self.alertTitle = "Permission Denied"
                        self.alertMessage = "Calendar access was not granted."
                    }
                }
            }
        @unknown default:
            print("Unknown case")
        }
    }

    func insertMedicationsIntoCalendar(_ store: EKEventStore) {
        let calendar = Calendar.current
        
        for medication in medications {
            let event = EKEvent(eventStore: store)
            event.title = "Time to take \(medication.name)"
            
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
            components.hour = medication.hour
            components.minute = medication.minute
            
            event.startDate = calendar.date(from: components)!
            event.endDate = event.startDate.addingTimeInterval(120)
    
            let frequencyDays = medication.frequency.days
            
            if let endDate = calendar.date(byAdding: .day, value: 28, to: Date()) {
                let recurrenceEnd = EKRecurrenceEnd(end: endDate)
                
                let recurrenceRule = EKRecurrenceRule(
                    recurrenceWith: .daily,
                    interval: frequencyDays,
                    end: recurrenceEnd
                )
                
                event.addRecurrenceRule(recurrenceRule)
            }
            
            event.calendar = store.defaultCalendarForNewEvents
            do {
                try store.save(event, span: .thisEvent)
            } catch let error {
                print("Error saving event: \(error)")
            }
        }
        
        showAlert = true
        alertTitle = "Success"
        alertMessage = "Medications have been synced with your calendar."
    }


    func removeExistingMedicationEvents(_ store: EKEventStore) {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        guard let endDate = calendar.date(byAdding: .day, value: 28, to: startDate) else {
            return
        }
        
        let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let events = store.events(matching: predicate)
        
        for event in events {
            if event.title.contains("Time to take") {
                do {
                    try store.remove(event, span: .thisEvent)
                } catch let error {
                    print("Error removing event: \(error)")
                }
            }
        }
    }

    func deleteMedication(at offsets: IndexSet) {
        for index in offsets {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [medications[index].id.uuidString])
        }
        medications.remove(atOffsets: offsets)
        saveMedications()
    }
    
    func loadMedications() {
        if let savedMedicationsData = UserDefaults.standard.data(forKey: "SavedMedications") {
            let decoder = JSONDecoder()
            if let savedMedications = try? decoder.decode([Medication].self, from: savedMedicationsData) {
                medications = savedMedications
            }
        }
    }
    
    func saveMedications() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(medications) {
            UserDefaults.standard.set(encodedData, forKey: "SavedMedications")
        }
    }
    
    func scheduleNotification(for medication: Medication) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = "Time to take your medication"
                content.body = "It's time to take your \(medication.name)."
                
                let calendar = Calendar.current
                let now = Date()
                
                var components = DateComponents()
                components.hour = medication.hour
                components.minute = medication.minute
                
                var trigger: UNNotificationTrigger?
                
                switch medication.frequency {
                case .daily:
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                case .everyTwoDays:
                    let nextDate = calendar.date(byAdding: .day, value: 2, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .everyThreeDays:
                    let nextDate = calendar.date(byAdding: .day, value: 3, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .everyFourDays:
                    let nextDate = calendar.date(byAdding: .day, value: 4, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .everyFiveDays:
                    let nextDate = calendar.date(byAdding: .day, value: 5, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .everySixDays:
                    let nextDate = calendar.date(byAdding: .day, value: 6, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .weekly:
                    let nextDate = calendar.date(byAdding: .weekOfYear, value: 1, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                }
                
                if let trigger = trigger {
                    let request = UNNotificationRequest(identifier: medication.id.uuidString, content: content, trigger: trigger)
                    center.add(request)
                }
            }
        }
    }
}

struct AddMedicationView: View {
    @Binding var medications: [Medication]
    @Binding var commonMedications: [MedicationModel]
    @State private var showAlert: Bool = false
    @State private var selectedMedication = MedicationModel(name: "Lisinopril", sideEffects: "Dizziness, lightheadedness, tiredness, or headache may occur as your body adjusts to the medication.", purpose: "Angiotensin-converting enzyme (ACE) inhibitor used to treat high blood pressure and heart failure")
    @State private var selectedFrequency: Frequency = .daily
    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0
    
    var body: some View {
        Form {
            Picker("Medication", selection: $selectedMedication) {
                ForEach(commonMedications, id: \.self) { medication in
                    Text(medication.name).tag(medication)
                }
            }
            
            Picker("Frequency", selection: $selectedFrequency) {
                ForEach(Frequency.allCases, id: \.self) { frequency in
                    Text(frequency.rawValue).tag(frequency)
                }
            }
            
            Picker("Hour", selection: $selectedHour) {
                ForEach(0..<24, id: \.self) {
                    Text("\($0)").tag($0)
                }
            }
            
            Picker("Minute", selection: $selectedMinute) {
                ForEach(0..<60, id: \.self) {
                    Text("\($0)").tag($0)
                }
            }
            
            Button(action: addMedication) {
                Text("Add Medication")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Medication has been added."), dismissButton: .default(Text("OK")))
        }
    }
    
    func addMedication() {
        let newMedication = Medication(name: selectedMedication.name, frequency: selectedFrequency, hour: selectedHour, minute: selectedMinute, sideEffects: selectedMedication.sideEffects)
        medications.append(newMedication)
        saveMedications()
        scheduleNotification(for: newMedication)
        showAlert = true
    }
    
    func saveMedications() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(medications) {
            UserDefaults.standard.set(encodedData, forKey: "SavedMedications")
        }
    }
    
    func scheduleNotification(for medication: Medication) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = "Time to take your medication"
                content.body = "It's time to take your \(medication.name)."
                
                let calendar = Calendar.current
                let now = Date()
                
                var components = DateComponents()
                components.hour = medication.hour
                components.minute = medication.minute
                
                var trigger: UNNotificationTrigger?
                
                switch medication.frequency {
                case .daily:
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                case .everyTwoDays:
                    let nextDate = calendar.date(byAdding: .day, value: 2, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .everyThreeDays:
                    let nextDate = calendar.date(byAdding: .day, value: 3, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .everyFourDays:
                    let nextDate = calendar.date(byAdding: .day, value: 4, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .everyFiveDays:
                    let nextDate = calendar.date(byAdding: .day, value: 5, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .everySixDays:
                    let nextDate = calendar.date(byAdding: .day, value: 6, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                case .weekly:
                    let nextDate = calendar.date(byAdding: .weekOfYear, value: 1, to: now, wrappingComponents: false)
                    trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    if let nextDate = nextDate {
                        trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
                    }
                }
                
                if let trigger = trigger {
                    let request = UNNotificationRequest(identifier: medication.id.uuidString, content: content, trigger: trigger)
                    center.add(request)
                }
            }
        }
    }
}

struct MedicationDetailsView: View {
    @Binding var commonMedications: [MedicationModel]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(commonMedications, id: \.self) { medication in
                    NavigationLink(destination: MedicationInfoView(medication: medication)) {
                        Text(medication.name)
                    }
                }
            }
            .navigationTitle("Medication Details")
        }
    }
}

struct MedicationInfoView: View {
    let medication: MedicationModel
    @State private var showSideEffects: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(medication.name)")
            Text("Purpose: \(medication.purpose)")
            Button(action: { showSideEffects.toggle() }) {
                Text("Show Side Effects")
            }
            .sheet(isPresented: $showSideEffects) {
                VStack(alignment: .leading) {
                    Text("Side Effects for \(medication.name)")
                    Text(medication.sideEffects)
                }
                .padding()
            }
        }
        .padding()
        .navigationTitle("\(medication.name)")
    }
}

