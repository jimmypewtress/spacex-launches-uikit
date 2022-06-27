//
//  LogoutUC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

protocol LogoutUC {
    func logout()
}

class LogoutUCImpl: LogoutUC {
    private let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func logout() {
        self.session.userDidLogout()
    }
}
