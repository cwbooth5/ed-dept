*** Settings ***
Documentation          This uses SSH to connect to a bunch of systems.

Library                SSHLibrary
Library                OperatingSystem

*** Variables ***

${servers}             Run Keyword    servers.txt    Get File
${USERNAME}            root
${PASSWORD}            gundog

*** Test Cases ***
Execute Command And Verify Output
    [Documentation]    For an IP in a list of servers, run a command.

    :FOR    ${addr}   IN    ${servers}
    \    Open Connection    ${addr}
    \    Login    ${USERNAME}    ${PASSWORD}
    \    ${output}=    Execute Command    cat /etc/passwd | cut -d: -f3
    \    Append To File   /root/output.txt    ${addr}
    \    OperatingSystem.Append To File    /root/cut.txt     ${output}
    \    Close All Connections