<h1>Caliditas-Pi</h1>
This is <b>BASH</b> script for <b>Raspberry Pi</b> used for <b>CPU</b> and <b>GPU</b> temperature scan.<br>
<b>Tested under:</b> Raspbian (Jessie) (Raspberry Pi3 Model B)<br><hr>
<h3>Software needed</h3><br>
Postfix, mailutils<br><hr>
<h3>Things you need to edit the file in order for the script to work</h3><br><br>
sendEmail - for notifications.<br>
CPU warn & shutdown temperatures.<br>
GPU warn & shutdown temperatures.<br>
<i><b>Optional</b>: warnLog - temporary log name</i><hr>

Edit crontab and add your script at the end<i>(the example here is on every 15 mins)</i><br>
<code>crontab -e</code><br>
<code>*/15 * * * * /path/to/caliditas-pi/caliditas.sh</code><br>
<h3>Example Log Emails</h3>
<b>Warning:</b><br>
[19.07.17][19:55:50]: This is a WARNING temperature message!!!<br>
[19.07.17][19:55:50]: Server: name.domain.eu<br>
[19.07.17][19:55:50]: CPU is passing critical temperature 30°C. Currently at  42°C.<br>
[19.07.17][19:55:50]: GPU is passing critical temperature 35°C. Currently at  42°C.<br>
[19.07.17][19:55:50]: Problems found: 2<br>
[19.07.17][19:55:50]: End of warning report.<br>

<b>Shutdown 1:</b><br>
[19.07.17][20:48:10]: This is a WARNING temperature message!!!<br>
[19.07.17][20:48:10]: Server: name.domain.eu<br>
[19.07.17][20:48:10]: CPU is overheating, current temperature 42°C. The system will be powered off!<br>
[19.07.17][20:48:10]: GPU is passing critical temperature 35°C. Currently at 42°C.<br>
[19.07.17][20:48:10]: Problems found: 2<br>
[19.07.17][20:48:10]: End of warning report.<br>

<b>Shutdown 2:</b><br>
[19.07.17][20:55:54]: This is a WARNING temperature message!!!<br>
[19.07.17][20:55:54]: Server: name.domain.eu<br>
[19.07.17][20:55:54]: CPU is overheating, current temperature 42°C. The system will be powered off!<br>
[19.07.17][20:55:54]: Problems found: 1<br>
[19.07.17][20:55:54]: GPU currently at: 42°C<br>
[19.07.17][20:55:54]: End of warning report.<br>
