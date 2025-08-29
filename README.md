## Usage

Open crontab:
```bash
crontab -e

Add this line to run the script every 5 minutes:

*/5 * * * * /root/scripts/check.sh
