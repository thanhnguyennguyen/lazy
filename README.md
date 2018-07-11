# lazy tools
 I hate doing repeated and bored things. I'm okay to spend a lot of time to write some scripts just in case I do something more than twice.
 It should be exactly done by my computer.
 
 - *JIRA*: update jira statuses and put some my review into Github pull request
    - Prerequiste: Install hub https://hub.github.com/ (to work with Git in command line)
    - Configuration:
        - put your jira credential (format:  username:password) in file jira_config.txt in the same folder
        - put your Github credential (format: username:yourtoken, generate here https://github.com/settings/tokens) in file github_config.txt in the same folder
        - update  BASE_JIRA_ISSUE_URL_REST, BASE_JIRA_ISSUE_URL, BASE_GITHUB_API_URL in jira.php
const JIRA_STATUSES
    - Usage: php jira.php [jira ticket key] [status you want to update] [message that you want to comment] [pull request number for review task]

 
