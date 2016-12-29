*** Settings ***
Documentation          This example demonstrates executing commands on a remote machine
...                    and getting their output and the return code.
...
...                    Notice how connections are handled as part of the suite setup and
...                    teardown. This saves some time when executing several test cases.

Library                SSHLibrary
Library                OperatingSystem

*** Variables ***

${servers}             Run Keyword    servers.txt    Get File
${USERNAME}            root
${PASSWORD}            gundog

*** Test Cases ***
Execute Command And Verify Output
    [Documentation]    Execute Command can be used to ran commands on the remote machine.
    ...                The keyword returns the standard output by default.

    :FOR    ${addr}   IN    ${servers}
    \    Open Connection    ${addr}
    \    Login    ${USERNAME}    ${PASSWORD}
    \    ${output}=    Execute Command    cat /etc/passwd | cut -d: -f3
    \    Append To File   /root/output.txt    ${addr}
    \    OperatingSystem.Append To File    /root/cut.txt     ${output}
    \    Close All Connections
