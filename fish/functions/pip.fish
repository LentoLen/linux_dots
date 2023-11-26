function pip
    switch $argv[1]
        case "-S"
            command pip install $argv[2..-1]
        case "-R"
            command pip uninstall $argv[2..-1]
        case '*'
            command pip $argv
    end
end
