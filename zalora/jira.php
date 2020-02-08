<?php
/**
 * Commit, push code to github and update Jira status
 * Created by NguyenNguyen(thanhnguyen.nguyen@zalora.com).
 * Project: SHOP
 * Date: 12/19/17
 */
const BASE_JIRA_ISSUE_URL_REST = 'https://zalora.atlassian.net/rest/api/2/issue/';
const BASE_JIRA_ISSUE_URL = 'https://zalora.atlassian.net/browse/';
const BASE_GITHUB_API_URL = 'https://api.github.com/repos/zalora/shop/';
const JIRA_STATUSES = [
    'readyforqa' => 641,
    'inqa' => 321,
    'readyforrelease' => 311,
    'stopdev' => 361,
    'waitingfordependencies' => 331,
    'backlog' => 261,
    'selectedfordev' => 281,
    'readyfordev' => 41,
    'resolved' => 241,
    'closed' => 251,
    'indev' => 51,
    'awaitingreview' => 111,
    'inreview' => 121,
    'reviewpassed' => 651,
    'reviewfailed' => 131
];
if ($argc < 2) {
    echo sprintf('Syntax %s --------------------------------------', PHP_EOL);
    echo 'jira.php [ticket_number] [jira_status] [github_commit_message] [pull_request_number]' . PHP_EOL;
    echo 'Ticket_number (*): SHOP-1234' . PHP_EOL;
    echo 'Jira Status (*): selectedfordev | readyfordev | indev | awaitingreview | inreview | reviewpassed | readyforqa | reviewfailed | inqa | readyforealease | stopdev | resolved | closed | waitingfordependencies | backlog' . PHP_EOL;
    echo 'github_commit_message (optional): Commit message' . PHP_EOL;
    echo 'pull_request_number (optional)' . PHP_EOL;
} else {
    $jiraConfig = file_get_contents('jira_config.txt');
    $ch = curl_init(BASE_JIRA_ISSUE_URL_REST . $argv[1]);
    curl_setopt($ch, CURLOPT_HTTPGET, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_USERPWD, $jiraConfig);
    curl_setopt(
        $ch,
        CURLOPT_HTTPHEADER,
        array('Content-Type:application/json', 'Accept: application/json')
    );
    $ticketInfo = json_decode(curl_exec($ch), true);
    curl_close($ch);

    if (empty($ticketInfo)) {
        echo 'Ticket not found!';
        return;
    }
    updateStatus($ticketInfo, $argv[2], $jiraConfig, $argv[3] ?? null, $argv[4] ?? null);
    echo sprintf('Done for %s!' . PHP_EOL, $argv[1]);
}

function commitCode($ticketInfo, $commitMessage = null)
{
    $ticketNumber = $ticketInfo['key'];
    $ticketTitle = isset($ticketInfo['fields']['summary']) ? $ticketInfo['fields']['summary'] : $ticketNumber;
    $commitMessage = $commitMessage ?? $ticketTitle;
    // commit changes to git
    exec(
        sprintf("git commit -m \"%s: %s\"", $ticketNumber, $commitMessage)
    );

    // push to remote
    exec(
        sprintf("git push -f origin %s", $ticketNumber)
    );

    if (empty($ticketInfo['fields']['customfield_12000']['pullrequest'])
        || empty($ticketInfo['fields']['customfield_12000']['pullrequest']['state'])
        || $ticketInfo['fields']['customfield_12000']['pullrequest']['state'] != 'OPEN') {
        // create a new pull request
        return shell_exec(
            sprintf("hub pull-request -m \"%s: %s\" -b rc", $ticketNumber, $ticketTitle)
        );
    }
}

function updateJiraStatus($ticketInfo, $idStatus, $jiraConfig)
{
    // change status  on JIRA
    $ticketNumber = $ticketInfo['key'];
    $ch = curl_init(BASE_JIRA_ISSUE_URL_REST . $ticketNumber . '/transitions?expand=transitions.fields');
    curl_setopt($ch, CURLOPT_USERPWD, $jiraConfig);
    curl_setopt($ch, CURLOPT_HTTPHEADER,
        array('Content-Type:application/json', 'Accept: application/json')
    );
    $jiraChange = [
        "transition" => ["id" => "$idStatus"]
    ];
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($jiraChange));
    curl_exec($ch);
    curl_close($ch);

}

function commentOnJira($ticketInfo, $message, $jiraConfig)
{
    $ticketNumber = $ticketInfo['key'];
    // comment on JIRA
    $ch = curl_init(BASE_JIRA_ISSUE_URL_REST . $ticketNumber . '/comment');
    curl_setopt($ch, CURLOPT_USERPWD, $jiraConfig);
    curl_setopt($ch, CURLOPT_HTTPHEADER,
        array('Content-Type:application/json', 'Accept: application/json')
    );
    $jiraMessage = [
        "body" => $message
    ];
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($jiraMessage));
    curl_exec($ch);
    curl_close($ch);

}

function startReviewOnGithub($pullRequest)
{
    $githubConfig = file_get_contents('github_config.txt');
    $ch = curl_init(BASE_GITHUB_API_URL . 'pulls/' . $pullRequest . '/reviews');
    $agent = 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)';
    curl_setopt($ch, CURLOPT_USERAGENT, $agent);
    curl_setopt($ch, CURLOPT_USERPWD, $githubConfig);
    curl_setopt($ch, CURLOPT_HTTPHEADER,
        array('Content-Type:application/json', 'Accept: application/json')
    );

    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response = curl_exec($ch);
    curl_close($ch);
    $data = json_decode($response, true);
    return $data['id'];

}

function submitReviewOnGithub($pullRequest, $reviewId, $message, $event)
{
    $githubConfig = file_get_contents('github_config.txt');
    $ch = curl_init(BASE_GITHUB_API_URL . 'pulls/' . $pullRequest . '/reviews/' . $reviewId . '/events');
    echo BASE_GITHUB_API_URL . 'pulls/' . $pullRequest . '/reviews/' . $reviewId . '/events';
    $agent = 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)';
    curl_setopt($ch, CURLOPT_USERAGENT, $agent);
    curl_setopt($ch, CURLOPT_USERPWD, $githubConfig);
    curl_setopt($ch, CURLOPT_HTTPHEADER,
        array('Content-Type:application/json', 'Accept: application/json')
    );
    $data = [
        "body" => $message,
        "event" => $event
    ];
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_exec($ch);
    curl_close($ch);

}


function updateStatus($ticketInfo, $status, $jiraConfig, $commitMessage = null, $pullRequest = null)
{
    switch ($status) {
        case 'indev':
            // checkout rc, git pull
            exec(sprintf('cd ~/shop; git checkout rc; git pull ; git checkout -b %s', $ticketInfo['key']));
            updateJiraStatus($ticketInfo, 51, $jiraConfig);
            //open the ticket in Jira to see requirements
            exec(sprintf('open -a "/Applications/Google Chrome.app"  "%s"', BASE_JIRA_ISSUE_URL . $ticketInfo['key']));
            break;
        case 'awaitingreview':
            $pullRequest = commitCode($ticketInfo, $commitMessage);
            updateJiraStatus($ticketInfo, 111, $jiraConfig);
            $jiraMessage = sprintf(
                "Hi [~%s] , %s Could you please arrange your time to help me review this ticket: %s %s Thanks, %s [~%s]",
                isset($ticketInfo['fields']['customfield_10204']['key']) ? $ticketInfo['fields']['customfield_10204']['key'] : '',
                PHP_EOL,
                $pullRequest,
                PHP_EOL,
                PHP_EOL,
                isset($ticketInfo['fields']['assignee']['key']) ? $ticketInfo['fields']['assignee']['key'] : ''
            );
            commentOnJira($ticketInfo, $jiraMessage, $jiraConfig);
            break;
        case 'inreview':
            exec(sprintf('cd ~/shop; git stash; git checkout master; git branch -D %s ; git pull ; git checkout %s',
                $ticketInfo['key'], $ticketInfo['key']));
            updateJiraStatus($ticketInfo, 121, $jiraConfig);
            //open the ticket in Jira to see requirements
            exec(sprintf('open -a "/Applications/Google Chrome.app"  "%s"', BASE_JIRA_ISSUE_URL . $ticketInfo['key']));
            break;
        case 'reviewpassed':
            $reviewId = startReviewOnGithub($pullRequest);
            $commitMessage = 'Review passed ' . $commitMessage;
            submitReviewOnGithub($pullRequest, $reviewId, $commitMessage, 'APPROVE');
            updateJiraStatus($ticketInfo, 651, $jiraConfig);
            $jiraMessage = sprintf(
                "Hi [~%s] , %s %s ",
                isset($ticketInfo['fields']['assignee']['key']) ? $ticketInfo['fields']['assignee']['key'] : '',
                PHP_EOL,
                $commitMessage
            );
            commentOnJira($ticketInfo, $jiraMessage, $jiraConfig);
            break;
        case 'reviewfailed':
            $reviewId = startReviewOnGithub($pullRequest);
            $commitMessage = 'Please check my comments in Github ' . $commitMessage;
            submitReviewOnGithub($pullRequest, $reviewId, $commitMessage, 'COMMENT');
            updateJiraStatus($ticketInfo, 131, $jiraConfig);
            $jiraMessage = sprintf(
                "Hi [~%s] , %s %s ",
                isset($ticketInfo['fields']['assignee']['key']) ? $ticketInfo['fields']['assignee']['key'] : '',
                PHP_EOL,
                $commitMessage
            );
            commentOnJira($ticketInfo, $jiraMessage, $jiraConfig);
            break;
        case 'readyforqa':
        case 'inqa':
        case 'readyforrelease':
        case 'stopdev':
        case 'waitingfordependencies':
        case 'backlog':
        case 'selectedfordev':
        case 'readyfordev':
        case 'resolved':
        case 'closed':
            updateJiraStatus($ticketInfo, JIRA_STATUSES[$status], $jiraConfig);
            break;
        default:
            break;
    }
}
