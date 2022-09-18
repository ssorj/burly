#!/usr/bin/bats

@test program_is_available {
    source burly.sh

    program_is_available cat
    ! program_is_available not-there
}

# @test port_is_active {
# }

# @test await_port_is_active {
# }

# @test await_port_is_free {
# }

@test string_is_match {
    source burly.sh

    string_is_match a a
    string_is_match a a\*
    string_is_match a \*
    ! string_is_match a b
    ! string_is_match a b\*
    ! string_is_match a a\?
}

@test random_number {
    source burly.sh

    first=$(random_number)
    sleep 1
    second=$(random_number)

    [ "$first" != "$second" ]
}

@test extract_archive {
    source burly.sh

    input_dir=$(mktemp -d)
    output_dir=$(mktemp -d)

    mkdir "${input_dir}/archive"
    echo "Hello" > "${input_dir}/archive/hello.txt"

    (
        cd "$input_dir"
        tar -cvf archive.tar archive
        gzip archive.tar
    )

    extract_archive "${input_dir}/archive.tar.gz" "$output_dir"

    [ $(cat "${output_dir}/archive/hello.txt") == "Hello" ]
}

@test assert {
    source burly.sh

    assert true
}

@test print_functions {
    source burly.sh

    {
        log hello
        run echo hello
        print
        print -n hello
        print hello
        print $(red hello)
        print $(yellow hello)
        print $(green hello)
        print_section section1
        print_result result
    } > /dev/null 3>&1
}

@test generate_password {
    source burly.sh

    generate_password
}

@test install_script_ash {
    if ! command -v ash
    then
        skip "Shell ash is not available"
    fi

    ash install.sh
}

@test install_script_bash {
    if ! command -v bash
    then
        skip "Shell bash is not available"
    fi

    bash install.sh
}

@test install_script_dash {
    if ! command -v dash
    then
        skip "Shell dash is not available"
    fi

    dash install.sh
}

@test install_script_ksh {
    skip "Aliasing for local mysteriously breaks under test"

    if ! command -v ksh
    then
        skip "Shell ksh is not available"
    fi

    ksh install.sh
}

@test install_script_mksh {
    if ! command -v mksh
    then
        skip "Shell mksh is not available"
    fi

    mksh install.sh
}

@test install_script_yash {
    if ! command -v yash
    then
        skip "Shell yash is not available"
    fi

    yash install.sh
}

@test install_script_zsh {
    if ! command -v zsh
    then
        skip "Shell zsh is not available"
    fi

    zsh install.sh
}
