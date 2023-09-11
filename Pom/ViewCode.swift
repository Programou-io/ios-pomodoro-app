protocol ViewCode {
    func configureViewCode()
    func configureActions()
    func configureStyle()
    func configureAccessibility()
    func configureHierarchy()
    func configureConstraints()
}

extension ViewCode {
    func configureViewCode() {
        configureActions()
        configureStyle()
        configureAccessibility()
        configureHierarchy()
        configureConstraints()
    }

    func configureStyle() {
        //Not implemented by default
    }

    func configureAccessibility() {
        //Not implemented by default
    }

    func configureActions() {
        //Not implemented by default
    }
}
