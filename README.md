# msp-it-support-automation
PowerShell-based Windows health checks and troubleshooting documentation for an MSP IT support lab
MSP IT Support Automation with PowerShell
Overview
This project demonstrates a basic Windows IT support diagnostic tool built using PowerShell.

The script collects information about network connectivity, DNS resolution, local disk capacity and selected Windows services. It writes the results to a text report for troubleshooting and documentation.

Objectives
Practise Windows desktop troubleshooting.
Automate routine diagnostic checks with PowerShell.
Understand basic DNS and network connectivity testing.
Inspect Windows services and disk capacity.
Produce a report that can support an IT incident investigation.
Technologies
Windows 10/11
Windows PowerShell
PowerShell cmdlets
Windows Management Instrumentation through CIM
GitHub
Features
Tests connectivity to an external IP address.
Tests DNS resolution for a domain.
Reports local disk capacity and available space.
Checks the status of selected Windows services.
Saves diagnostic results to a text file.
How to Run
Download system-health-check.ps1.
Open PowerShell.
Navigate to the downloaded script’s directory.
Run:
.\system-health-check.ps1

Review the generated health-report.txt file.
Execution policies and organisational security controls may affect script execution.

Troubleshooting Scenarios
The lab explores:

DNS resolution failures.
Network connectivity problems.
Low disk space.
Print Spooler service issues.
Windows service status checks.
Limitations
A successful ping does not guarantee that all internet services are accessible.
DNS resolution is tested against one configured domain.
Service status checks do not verify application functionality.
The script is intended for a learning environment and has not been validated as a production monitoring solution.
Future Improvements
Add structured logging and severity levels.
Generate CSV or HTML reports.
Support configurable diagnostic targets.
Add unit tests and more comprehensive error handling.
Integrate with a ticketing workflow.
Disclaimer
This project is for educational and portfolio purposes. Test it only on systems you are authorised to access.

Only describe features you’ve actually implemented and tested. If you haven’t completed the future improvements, leave them under that heading rather than claiming they’re finished.
