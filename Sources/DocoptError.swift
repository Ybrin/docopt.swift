//
//  DocoptError.swift
//  docopt
//
//  Created by Pavel S. Mazurin on 3/1/15.
//  Copyright (c) 2015 kovpas. All rights reserved.
//

import Foundation
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

internal class DocoptError {
    var message: String
    var name: String
    static var test: Bool = false
    init (_ message: String, name: String) {
        self.message = message
        self.name = name
    }

    func raise(_ message: String? = nil) {
        let msg = (message ?? self.message).strip()
        if (DocoptError.test) {
            print("NSExceptionName.internalInconsistencyException: \(msg)")
            exit(1)
        } else {
            print(msg)
            exit(0)
        }
    }
}

internal class DocoptLanguageError: DocoptError {
    init (_ message: String = "Error in construction of usage-message by developer.") {
        super.init(message, name: "DocoptLanguageError")
    }
}

internal class DocoptExit: DocoptError {
    static var usage: String = ""
    init (_ message: String = "Exit in case user invoked program with incorrect arguments.") {
        super.init(message, name: "DocoptExit")
    }

    override func raise(_ message: String? = nil) {
        super.raise("\(DocoptExit.usage)")
    }
}
